{
  # nixpkgs dependencies
  stdenv, cmake, catch2, openssl, # ... other deps here

  # xo dependencies
  xo-cmake, xo-pyutil, xo-websock, xo-pywebutil, #xo-pyreactor,

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
    name = "xo-pywebsock";

    src = (fetchGit {
      url = "https://github.com/rconybea/xo-pywebsock";
      version = "1.0";
      #ref = "ex1";
      #rev = "c0472c9d7e4d2c53bfb977d3182380832fe96645";
    });

    cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo-cmake}/share/cmake"];
    doCheck = true;
    nativeBuildInputs = [ cmake catch2 openssl xo-pyutil ];
    propagatedBuildInputs = [ xo-websock xo-pywebutil
                              #xo-pywebutil #xo-pyreactor
                            ];
  })
