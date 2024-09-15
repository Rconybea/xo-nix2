{
  # nixpkgs dependencies
  stdenv, cmake, catch2, # ... other deps here

  # xo dependencies
  xo-cmake, xo-pyutil, xo-webutil,

  # args

  #   attrset for fetching source code.
  #    { type, owner, repo, ref }
  #
  #   e.g. type="github", owner="rconybea", repo="cmake-examples", ref="ex1b"
  #
  #   see [[../flake.nix]]
  #
  #cmake-examples-ex1-path

  # someconfigurationoption ? false
} :

stdenv.mkDerivation (finalattrs:
  {
    name = "xo-pywebutil";

    src = (fetchGit {
      url = "https://github.com/rconybea/xo-pywebutil";
      version = "1.0";
      #ref = "ex1";
      #rev = "c0472c9d7e4d2c53bfb977d3182380832fe96645";
    });

    cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo-cmake}/share/cmake"
                  "-DXO_CMAKE_CONFIG_EXECUTABLE=${xo-cmake}/bin/xo-cmake-config"];
    doCheck = true;
    nativeBuildInputs = [ cmake catch2 xo-pyutil ];
    propagatedBuildInputs = [ xo-webutil ];
  })
