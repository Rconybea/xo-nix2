{ stdenv, fetchgit, cmake, catch2, indentlog, refcnt, subsys }:

stdenv.mkDerivation rec {
  name = "reflect";

  src = fetchgit {
    url = "https://github.com/rconybea/reflect";
    rev = "d7232b4da6a9c06ce24f892c65db0b5da143f6ec";
    sha256 = "b8Rtnh8cNXnl3Bc2KshU+o1EmjdZxUeeK9J+K8QNsWY=";
  };

  buildInputs = [ indentlog
                  refcnt
                  subsys
                  cmake
                  catch2
                ];
}
