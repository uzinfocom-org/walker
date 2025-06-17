{
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: let
  lib = pkgs.lib;
in
  pkgs.stdenv.mkDerivation rec {
    pname = "docx";
    version = "0.0.1";

    src = ./.;

    nativeBuildInputs = with pkgs; [
      pandoc
    ];

    buildPhase = ''
      # Convert to markdown files
      for d in ./docs/* ; do
       pandoc -d $d/${pname}.yaml
      done
    '';

    installPhase = ''
      # Create output dir
      mkdir -p $out/docx

      # Move content to output
      mv ./*.${pname} $out/docx
    '';

    meta = {
      description = "Docx output of a document";
      maintainers = [
        lib.maintainers.orzklv
      ];
    };
  }
