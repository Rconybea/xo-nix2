{
  # characterize this flake
  description = "XO flake repo";

  # dependencies of this flake
  inputs = {
    #nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/5d017a8822e0907fb96f7700a319f9fe2434de02.tar.gz";
    #nixpkgs.url = "github:nixos/nixpkgs/23.05";  # this is 23.05 as of it's original release.  e.g. no emacs29

    # to get specific hash:
    # 1. cd ~/proj/nixpkgs
    # 2. git checkout release-23.05
    # 3. git fetch
    # 4. git pull
    # 5. git log -1;  take this hash
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/fac3684647cc9d6dfb2a39f3f4b7cf5fc89c96b6.tar.gz";

    xo_cmake_path = {
      type = "github";
      owner = "Rconybea";
      repo = "xo-cmake";
      #ref = "v1.0";
      #url = "https://github.com/Rconybea/xo-cmake";
      #rev = "v1.0";
      flake = false; };

    indentlog_path      = { type = "github"; owner = "Rconybea"; repo = "indentlog";      flake = false; };
    refcnt_path         = { type = "github"; owner = "Rconybea"; repo = "refcnt";         flake = false; };
    subsys_path         = { type = "github"; owner = "Rconybea"; repo = "subsys";         flake = false; };
    reflect_path        = { type = "github"; owner = "Rconybea"; repo = "reflect";        flake = false; };
    randomgen_path      = { type = "github"; owner = "Rconybea"; repo = "randomgen";      flake = false; };
    xo_ordinaltree_path = { type = "github"; owner = "Rconybea"; repo = "xo-ordinaltree"; flake = false; };
    xo_pyutil_path      = { type = "github"; owner = "Rconybea"; repo = "xo-pyutil";      flake = false; };
    xo_pyreflect_path   = { type = "github"; owner = "Rconybea"; repo = "xo-pyreflect";   flake = false; };
    xo_printjson_path   = { type = "github"; owner = "Rconybea"; repo = "xo-printjson";   flake = false; };
    xo_callback_path    = { type = "github"; owner = "Rconybea"; repo = "xo-callback";    flake = false; };
    xo_webutil_path     = { type = "github"; owner = "Rconybea"; repo = "xo-webutil";     flake = false; };
    xo_reactor_path     = { type = "github"; owner = "Rconybea"; repo = "xo-reactor";     flake = false; };
    xo_websock_path     = { type = "github"; owner = "Rconybea"; repo = "xo-websock";     flake = false; };

    # REMEMBER to ADD to outputs BELOW

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
  outputs = { self,
              nixpkgs,
              xo_cmake_path,
              indentlog_path,
              refcnt_path,
              subsys_path,
              reflect_path,
              randomgen_path,
              xo_ordinaltree_path,
              xo_pyutil_path,
              xo_pyreflect_path,
              xo_printjson_path,
              xo_callback_path,
              xo_webutil_path,
              xo_reactor_path,
              xo_websock_path} :
    let
      system = "x86_64-linux";
      #xo_cmake_dir = self.packages.${system}.xo_cmake;
      pkgs = import nixpkgs { inherit system; };
      xo_pkgs = self.packages.${system};

      # NOTE:
      #   nativeBuildInputs:  inputs needed at build-time,  but not propagated to run time
      #   buildInputs:        inputs needed at build-time,  but that should also be available
      #                       at run-time
      #
      #   propagatedNativeBuildInputs: inputs needed at build-time for a package X,
      #                                that should also be available (but only needed at build-time)
      #                                in other packages Y that have X as an input
      #                                (-> ./result/nix-support/propagated-native-build-inputs)
      #
      #   propagatedBuildInputs:       inputs needed at build-time + run-time for a package X,
      #                                that should also be available in other packages Y that depend on X
      #                                (-> ./result/nix-support/propagated-build-inputs)
      #
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
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 ];
          propagatedBuildInputs = [ ];
        };
      refcnt_deriv = pkgs.stdenv.mkDerivation
        {
          name = "refcnt";
          version = "0.1";
          src = refcnt_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 ];
          propagatedBuildInputs = [ xo_pkgs.indentlog ];
        };
      subsys_deriv = pkgs.stdenv.mkDerivation
        {
          name = "subsys";
          version = "0.1";
          src = subsys_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 ];
          propagatedBuildInputs = [ ];
        };
      reflect_deriv = pkgs.stdenv.mkDerivation
        {
          name = "reflect";
          version = "0.1";
          src = reflect_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 ];
          propagatedBuildInputs = [ xo_pkgs.subsys xo_pkgs.refcnt ];
        };
      randomgen_deriv = pkgs.stdenv.mkDerivation
        {
          name = "randomgen";
          version = "0.1";
          src = randomgen_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake ];
          propagatedBuildInputs = [ xo_pkgs.indentlog ];
        };
      xo_ordinaltree_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_ordinaltree";
          version = "0.1";
          src = xo_ordinaltree_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          # note: randomgen needed only at build-time, for unit tests
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.randomgen ];
          propagatedBuildInputs = [ xo_pkgs.refcnt ];
        };
      xo_pyutil_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_pyutil";
          version = "0.1";
          src = xo_pyutil_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2  ];
          # we want to enforce: packages depending on this pyutil must all use the same pybind11+python version
          propagatedBuildInputs = [ pkgs.python311Full pkgs.python311Packages.pybind11 ];
        };
      xo_pyreflect_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_pyreflect";
          version = "0.1";
          src = xo_pyreflect_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          buildFlags = ["VERBOSE=1"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.xo_pyutil ];
          propagatedBuildInputs = [ xo_pkgs.reflect ];
        };
      xo_printjson_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_printjson";
          version = "1.0";
          src = xo_printjson_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 ];
          propagatedBuildInputs = [ xo_pkgs.reflect ];
        };
      xo_callback_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_callback";
          version = "1.0";
          src = xo_callback_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake ];
          propagatedBuildInputs = [ xo_pkgs.refcnt ];
        };
      xo_webutil_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_webutil";
          version = "1.0";
          src = xo_webutil_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          nativeBuildInputs = [ pkgs.cmake ];
          propagatedBuildInputs = [ xo_pkgs.refcnt xo_pkgs.xo_callback ];
        };
      xo_reactor_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_reactor";
          version = "1.0";
          src = xo_reactor_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          # note: randomgen needed only at build-time, for unit tests
          nativeBuildInputs = [ pkgs.cmake pkgs.catch2 xo_pkgs.randomgen ];
          propagatedBuildInputs = [ xo_pkgs.xo_webutil xo_pkgs.xo_callback xo_pkgs.reflect xo_pkgs.xo_printjson xo_pkgs.xo_ordinaltree ];
        };
      xo_websock_deriv = pkgs.stdenv.mkDerivation
        {
          name = "xo_websock";
          version = "1.0";
          src = xo_websock_path;
          cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake_dir}"];
          # note: randomgen needed only at build-time, for unit tests
          nativeBuildInputs = [ pkgs.cmake pkgs.libwebsockets pkgs.openssl pkgs.jsoncpp ];
          propagatedBuildInputs = [ xo_pkgs.xo_webutil xo_pkgs.xo_reactor ];
        };

    in rec {
      packages.${system} = {
        cowsay = pkgs.cowsay;

        xo_cmake = xo_cmake_deriv;
        indentlog = indentlog_deriv;
        refcnt = refcnt_deriv;
        subsys = subsys_deriv;
        reflect = reflect_deriv;
        randomgen = randomgen_deriv;
        xo_ordinaltree = xo_ordinaltree_deriv;
        xo_pyutil = xo_pyutil_deriv;
        xo_pyreflect = xo_pyreflect_deriv;
        xo_printjson = xo_printjson_deriv;
        xo_callback = xo_callback_deriv;
        xo_webutil = xo_webutil_deriv;
        xo_reactor = xo_reactor_deriv;
        xo_websock = xo_websock_deriv;

        ## importing non-flake nix package:
        # mything = pkgs.callPackages ./pkgs/mything {};
      };

      devShells.${system} = {
        # python311Packages.pybind11: used by xo_pyutil, xo_pyreflect etc.
        # libwebsockets:              used by xo_websock
        # openssl:                    used by xo_websock (transitively, via libwebsockets)
        # jsoncpp:                    used by xo_websock
        # semgrep:                    emacs->lsp->clangd install needs this

        default = pkgs.mkShell { packages = [ pkgs.emacs29
                                              pkgs.semgrep
                                              pkgs.cmake
                                              pkgs.catch2
                                              pkgs.which
                                              pkgs.lcov

                                              pkgs.python311Full
                                              pkgs.python311Packages.pybind11

                                              pkgs.libwebsockets
                                              pkgs.openssl
                                              pkgs.jsoncpp
        ]; };
      };
    };
}
