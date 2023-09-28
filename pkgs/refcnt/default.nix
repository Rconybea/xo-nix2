{ stdenv, fetchgit, cmake, catch2, indentlog, xo_cmake }:

stdenv.mkDerivation rec {
  name = "refcnt";

  src = fetchgit {
    url = "https://github.com/rconybea/refcnt";
    rev = "870eb57aa79c9ad0369a0471308d0f93df598716";
    sha256 = "HPVTqd8obIxxeL8hM+h+peBP/KaIMK1DkcX42AQPiCM=";

  };

  cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake}/share/cmake"];

  buildInputs = [ indentlog
                  cmake
                  catch2
                  xo_cmake
                ];
}
