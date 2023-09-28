{
  description = "XO: common cmake modules";

  # dependencies of this flake
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
  };

  # function: inputs -> set
  #
  outputs = { self, nixpkgs }:
    {
      packages.x86_64-linux.xo_cmake =
        let pkgs = import nixpkgs {
              system = "x86_64-linux";
            };
        in pkgs.stdenv.mkDerivation {
          pname = "xo-cmake";
          # version = ...;

          src = pkgs.fetchgit {
            url = "https://github.com/rconybea/xo-cmake";
            rev = "d349796363163419026d7ced0f46f3702ba4a2df";
            sha256 = "vak8TfHbHr/lHcZEsB6qjvoVM6xTdlu9EVbQbhJwPrE=";
          };

          nativeBuildInputs = with pkgs;
            [
              cmake
            ];
        };
    };
}
