{
  description = "XO: indenting logger";

  # dependencies of this flake
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";

    xo_cmake.url = "./../xo-cmake";

    xo_indentlog_path = {
      type = "github";
      owner = "Rconybea";
      repo = "indentlog";
      flake = false;
    };
  };

  # function: inputs -> set
  #
  outputs = { self, nixpkgs, xo_cmake, xo_indentlog_path } :
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.xo_cmake = pkgs.stdenv.mkDerivation
          {
            name = "xo-cmake";

            version = "1.0";

            src = xo_indentlog_path;

#            src = pkgs.fetchgit {
#              #url = xo_cmake_path;
#              #url = "github:Rconybea/xo-cmake";  # doesn't work
#              #url = "https://github.com/Rconybea/xo-cmake";
#              url = xo_cmake_path.url;
#              rev = "v1.0";
#            };

            nativeBuildInputs = with pkgs;
              [
                cmake
                xo_cmake
              ];
          };

      defaultPackage.${system} = self.packages.${system}.xo_cmake;
    };
}
