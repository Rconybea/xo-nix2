# Adding an xo library

1. add ./pkgs/xo-foo.nix
2. edit ./flake.nix;  visit placeholder-A .. placeholder-E
3. commit to git (build needs commit hash for ./pkgs/xo-foo.nix to work)
4. nix build -L --print-build-logs .#xo-foo
