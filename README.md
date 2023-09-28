See [https://ipetkov.dev/blog/tips-and-tricks-for-nix-flakes](ipetkov blog)

```
# NOTE: must be committed to git

$ cd flakes/xo-cmake
$ nix flake check
```

```
$ cd flakes/xo-cmake
$ nix flake show
```

```
$ cd flakes/xo-cmake
$ nix build .#xo_cmake  # or nix build .#packages.x86_64-linux.xo_cmake
```
here:
1. `.` gives relative path to target `flake.nix` definition
2. `#` is a separator;  just syntax
3. `xo_cmake` is an attribute provided by target `flake.nix`

```
$ nix run cowsay hello
```
