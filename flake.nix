{
  # characterize this flake
  description = "XO flake repo";

  # dependencies of this flake
  inputs = rec {
    #nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/5d017a8822e0907fb96f7700a319f9fe2434de02.tar.gz";
    nixpkgs.url = "github:nixos/nixpkgs/23.05";

#    xo_cmake_path = {
#      type = "github"; owner = "Rconybea"; repo = "xo-cmake"; ref = "v1.0";
#      flake = false;
#    };

    xo_cmake_path = {
      type = "github";
      owner = "Rconybea";
      repo = "xo-cmake";
      #ref = "v1.0";
      #url = "https://github.com/Rconybea/xo-cmake";
      #rev = "v1.0";
      flake = false;
    };

    indentlog_path = {
      type = "github";
      owner = "Rconybea";
      repo = "indentlog";
      flake = false;
    };

    refcnt_path = {
      type = "github";
      owner = "Rconybea";
      repo = "refcnt";
      flake = false;
    };

    subsys_path = {
      type = "github";
      owner = "Rconybea";
      repo = "subsys";
      flake = false;
    };

    reflect_path = {
      type = "github";
      owner = "Rconybea";
      repo = "reflect";
      flake = false;
    };

#    # use [flakes/xo-cmake],  but:
#    # - use nixpkgs established here
#    # - use xo_cmake source established here
#    xo_cmake = {
#      url = "./flakes/xo-cmake";
#      #inputs.nixpkgs.follows = "nixpkgs";
#      #inputs.xo_cmake_path.follows = "xo_cmake_path";
#    };

#    indentlog_flake = {
#      url = "./flakes/indentlog";
#      inputs.nixpkgs.follows = "nixpkgs";
#    };
  };

#  outputs = { self, nixpkgs, xo_cmake_path, xo_cmake } :
#  outputs = { self, nixpkgs, xo_cmake } :
  outputs = { self, nixpkgs, xo_cmake_path, indentlog_path, refcnt_path, subsys_path, reflect_path } :
    let
      system = "x86_64-linux";
      #xo_cmake_dir = self.packages.${system}.xo_cmake;
      pkgs = import nixpkgs { inherit system; };
      xo_pkgs = self.packages.${system};
      xo_cmake_deriv = pkgs.stdenv.mkDerivation
        {
            name = "xo-cmake";
            version = "1.0";
            src = xo_cmake_path;
            nativeBuildInputs = [ pkgs.cmake ];
        };
      # XO shared .cmake files, e.g. xo_cxx.cmake
      xo_cmake_dir = "${self.packages.${system}.xo_cmake}/share/cmake";
      indentlog_deriv = pkgs.stdenv.mkDerivation
        {
          name = "indentlog";
          version = "0.1";
          src = indentlog_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 self.packages.${system}.xo_cmake ];
        };
      refcnt_deriv = pkgs.stdenv.mkDerivation
        {
          name = "refcnt";
          version = "0.1";
          src = refcnt_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.xo_cmake xo_pkgs.indentlog ];
        };
      subsys_deriv = pkgs.stdenv.mkDerivation
        {
          name = "subsys";
          version = "0.1";
          src = subsys_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.xo_cmake ];
        };
      reflect_deriv = pkgs.stdenv.mkDerivation
        {
          name = "reflect";
          version = "0.1";
          src = reflect_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.xo_cmake xo_pkgs.indentlog xo_pkgs.subsys xo_pkgs.refcnt ];
        };

    in rec {
      packages.${system} = {
        cowsay = pkgs.cowsay;

        xo_cmake = xo_cmake_deriv;
        indentlog = indentlog_deriv;
        refcnt = refcnt_deriv;
        subsys = subsys_deriv;
        reflect = reflect_deriv;

#        xo_cmake = xo_cmake.packages.${system}.xo_cmake;
#        indentlog = indentlog_flake.packages.${system}.indentlog;

        ## importing non-flake nix package:
        # mything = pkgs.callPackages ./pkgs/mything {};
      };
    };
}
