# standartization

📄 | Documents for getting projects standartized

## TODOs

- Write a rust program that will:
  - Have github link passed as arg
  - Clone master branch
  - Walk by every source code with specific extention passed via arg
  - Get number of lines of code in every source code file
  - Get sha256 of every source code file
  - If there's dictionary.toml, match path and insert description automatically.
  - Look for passed markdown file, if exists, look for "#@SCT@#"
  - Replace "#@SCT@#" with produced markdown table

## Examples

**Example Command:**

johnny -ext ".rs" -dict ./dictionary.toml https://github.com/xinux-org/templates

**Example Dictionary:**

```toml
[[definitions]]
"path" = "./src/some/shit.rs"
"definition" = "This file holds codebase for adding, deleting and editing shitcoders"
#? "network" = ""
```

## Helpful

- https://crates.io/crates/walkdir
