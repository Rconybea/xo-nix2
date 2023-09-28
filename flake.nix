{
  # characterize this flake
  description = "A very basic flake";

  # dependencies of this flake
  inputs = rec {
    #nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/5d017a8822e0907fb96f7700a319f9fe2434de02.tar.gz";
    nixpkgs.url = "github:nixos/nixpkgs/23.05";

    xo_cmake = {
      url = "path:flakes/xo-cmake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, xo_cmake } :
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system} = rec {
      };
    };

#  # function inputs -> set
#  # structure of set should be like:
#  #   packages|devShells|checks ..
#  #     targetarchitecture
#  #       outputname
#  # note however that templates,overlays omit the targetarchitecture layer
#  #
#  outputs = { self, nixpkgs }:
#    let
#      system = "x86_64-linux";
#      pkgs = import nixpkgs { inherit system; };
#    in {
#      packages.${system} = rec {
#        # NOTE: ./pkgs tree has to be committed to git for any of the below to work!
#
#        # pulling in a separate flake,  but replacing one of its inputs
#
#        xo_cmake = pkgs.callPackage ./pkgs/xo-cmake {};
#        #hello = nixpkgs.legacyPackages.x86_64-linux.hello;
#        #default = self.packages.x86_64-linux.hello;
#      };
#    };
}
