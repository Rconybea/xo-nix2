{ stdenv, fetchgit, cmake, catch2, xo_cmake }:

stdenv.mkDerivation rec {
  name = "subsys";

  src = fetchgit {
    url = "https://github.com/rconybea/subsys";
    rev = "5f025d8fc8c12ab8792faf71bc5baa93784efa5a";
    sha256 = "ByDuUcAKmH6SAKBT6E3gEpY5/Vu4SbxchBC+hMI+Png=";
  };

  cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake}/share/cmake"];

  buildInputs = [
                  cmake
                  catch2
                  xo_cmake
                ];
}
