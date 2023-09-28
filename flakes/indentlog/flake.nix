{
  description = "XO: indenting logger";

  # dependencies of this flake
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";

    # this is bad!   will cause indentlog and toplevel xo to fight over follows
    xo_cmake_flake.url = "../xo-cmake";

    xo_indentlog_path = {
      type = "github";
      owner = "Rconybea";
      repo = "indentlog";
      flake = false;
    };
  };

  # function: inputs -> set
  #
  outputs = { self, nixpkgs, xo_cmake_flake, xo_indentlog_path } :
    let
      system = "x86_64-linux";
      xo_cmake = xo_cmake_flake.packages.${system}.xo_cmake;
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.indentlog = pkgs.stdenv.mkDerivation
          {
            name = "xo-cmake";

            #version = "0.1";

            src = xo_indentlog_path;

            cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake}/share/cmake"];

            nativeBuildInputs =
              [
                pkgs.cmake
                pkgs.catch2
                xo_cmake
              ];
          };

      defaultPackage.${system} = self.packages.${system}.indentlog;
    };
}
