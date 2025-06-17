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
      # Convert markdown
      pandoc -d ./docs/efael/config.yaml
      pandoc -d ./docs/xinux/config.yaml
    '';

    installPhase = ''
      # Create output dir
      mkdir -p $out/docx

      # Move content to output
      mv ./efael.${pname} $out/docx
      mv ./xinux.${pname} $out/docx
    '';

    meta = {
      description = "Docx output of a document";
      maintainers = [
        lib.maintainers.orzklv
      ];
    };
  }
