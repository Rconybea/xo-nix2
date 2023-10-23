See [https://ipetkov.dev/blog/tips-and-tricks-for-nix-flakes](ipetkov blog)

```
# NOTE: must be committed to git

$ cd xo-nix2
$ nix flake check
```

# Anatomy
```
$ nix flake show
git+file:///home/roland/proj/xo-nix2?ref=refs/heads/main&rev=c5f455b1508ed00ed291ff536e93c69a0fa77cc1
└───packages
    └───x86_64-linux
        ├───cowsay: package 'cowsay-3.7.0'
        ├───indentlog: package 'indentlog'
        ├───refcnt: package 'refcnt'
        ├───reflect: package 'reflect'
        ├───subsys: package 'subsys'
        └───xo_cmake: package 'xo-cmake'
$ nix flake metadata
Resolved URL:  git+file:///home/roland/proj/xo-nix2
Locked URL:    git+file:///home/roland/proj/xo-nix2
Description:   XO flake repo
Path:          /nix/store/1a9layvq8j93y72a4gyzfcqrqagf17xa-source
Last modified: 2023-09-28 16:52:31
Inputs:
├───indentlog_path: github:Rconybea/indentlog/afd595185b5d4b879a19eb03af3d8e971feffdcc
├───nixpkgs: github:nixos/nixpkgs/4ecab3273592f27479a583fb6d975d4aba3486fe
├───refcnt_path: github:Rconybea/refcnt/4e0c8e92f236ebfce2b345b686f8b45fc26ba8b7
├───reflect_path: github:Rconybea/reflect/94d77bf809900b2458f87dfe43d8698b1910230c
├───subsys_path: github:Rconybea/subsys/4600ebcb213914af4637b20eaad5cae5bd667dff
└───xo_cmake_path: github:Rconybea/xo-cmake/f38f48943762a2bc72efd27ef1ee7dbab7ce6ee2
```
note: since we provided repo paths in `xo-nix2/flake.nix`:
```
    subsys_path = {
      type = "github";
      owner = "Rconybea";
      repo = "subsys";
      flake = false;
    };
    ...
```
we get entries in `flake.lock`,  and `nix flake show` displays:
```
├───subsys_path: github:Rconybea/subsys/4600ebcb213914af4637b20eaad5cae5bd667dff
```

in `flake.lock`:
```
    ...
    "subsys_path": {
      "flake": false,
      "locked": {
        "lastModified": 1695853374,
        "narHash": "sha256-gQju6iPssKI0Sqkw0sh4yfmYJjbSOM3by3UbahT6gIc=",
        "owner": "Rconybea",
        "repo": "subsys",
        "rev": "4600ebcb213914af4637b20eaad5cae5bd667dff",
        "type": "github"
      },
      "original": {
        "owner": "Rconybea",
        "repo": "subsys",
        "type": "github"
      }
    },
    ...
```

```
$ cat flake.lock
{
  "nodes": {
    "indentlog_path": {
      "flake": false,
      "locked": {
        "lastModified": 1695853401,
        "narHash": "sha256-CBuUuFAPvFvAEQAW5UlLX7bn6IUJogDwFgOAQmrzJQ4=",
        "owner": "Rconybea",
        "repo": "indentlog",
        "rev": "afd595185b5d4b879a19eb03af3d8e971feffdcc",
        "type": "github"
      },
      "original": {
        "owner": "Rconybea",
        "repo": "indentlog",
        "type": "github"
      }
    },
    "nixpkgs": {
      "locked": {
        "lastModified": 1685566663,
        "narHash": "sha256-btHN1czJ6rzteeCuE/PNrdssqYD2nIA4w48miQAFloM=",
        "owner": "nixos",
        "repo": "nixpkgs",
        "rev": "4ecab3273592f27479a583fb6d975d4aba3486fe",
        "type": "github"
      },
      "original": {
        "owner": "nixos",
        "ref": "23.05",
        "repo": "nixpkgs",
        "type": "github"
      }
    },
    ...
```

# Build
```
$ nix build .#reflect
```

# Update versions

(changes hashes in `flake.lock`)
```
$ nix flake update
```

# Development

Creates shell containing all the packages in `devShells.${system}`
```
$ nix develop
```

Hermetic: similar to above,  but discards everything in user environment except {HOME, TERM, DISPLAY}
```
$ nix develop -i --keep HOME --keep TERM --keep DISPLAY
```

