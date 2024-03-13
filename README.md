# Introduction

- Nix build for xo libraries.
- Motivation/Discussion: https://rconybea.github.io/web/nix/nix-for-your-own-project.html

# Build

```
$ nix build -L --print-build-logs .#xo-cmake
$ nix build -L --print-build-logs .#xo-indentlog
```

Can omit `-L --print-build-logs` for terse output

# Update versions

Updates hashes in `flake.lock` it some upstream repo has changed
```
$ nix flake update
```

# Develop

Creates shell containing all the packages in `devShells.${system}`.
On top of existing environment (prepends PATH etc)

```
$ nix develop
```

Hermetic: similar to above,  but discards everything already in user environment
```
$ nix develop -i
```

Hermetic with exceptions: preserve identified environment variables
```
$ nix develop -i --keep HOME --keep TERM --keep DISPLAY --keep SSH_AUTH_SOCK --keep SSH_AGENT_PID --keep CONFIG_SHELL
```

# Examine flake contents

```
$ nix flake show
git+file:///home/roland/proj/xo-nix4
├───devShells
|   |   ...
│   └───x86_64-linux
│       └───default: development environment 'nix-shell'
├───overlays
    ...
    └───x86_64-linux
        ├───xo-callback: package 'xo-callback'
        ├───xo-cmake: package 'xo-cmake'
        ├───xo-distribution: package 'xo-distribution'
        ├───xo-indentlog: package 'xo-indentlog'
        ├───xo-kalmanfilter: package 'xo-kalmanfilter'
        ├───xo-ordinaltree: package 'xo-ordinaltree'
        ├───xo-printjson: package 'xo-printjson'
```

# Examine pins

```
$ nix flake metadata
Resolved URL:  git+file:///home/roland/proj/xo-nix4
Locked URL:    git+file:///home/roland/proj/xo-nix4
Description:   xo: c++/python libraries for complex event processing
Path:          /nix/store/2ngdimpb8jy0dnyqrf5rrqz1q6m0286n-source
Last modified: 2024-03-12 21:05:41
Inputs:
├───flake-utils: github:numtide/flake-utils/b1d9ab70662946ef0850d488da1c9019f3a9752a
│   └───systems: github:nix-systems/default/da67096a3b9bf56a91d16901293e51ba5b49a27e
├───nixpkgs: https://github.com/NixOS/nixpkgs/archive/217b3e910660fbf603b0995a6d2c3992aef4cc37.tar.gz?narHash=sha256-ci7ghtn0YKXw68Wkufou0DK3pwTmkfWeFOYkRsnLagc%3D
├───xo-callback-path: github:Rconybea/xo-callback/dd01874b2ea023202f3084f92c31199e7fa03e2c
├───xo-cmake-path: github:Rconybea/xo-cmake/ffd8e9dca998712c5edfa1898b0745271d54176e
├───xo-distribution-path: github:Rconybea/xo-distribution/09cb38f26565d769d89bee5eefadd5fe3bfad3db
...
```

# Links

- https://github.com/vlktomas/nix-examples         Tomas Vlk nix examples
- https://ryantm.github.io/nixpkgs/stdenv/stdenv   nix stdenv
- https://jade.fyi/blog/#flakes-arent-real         Jade Lovelace editorial on flakes+nixpkgs
