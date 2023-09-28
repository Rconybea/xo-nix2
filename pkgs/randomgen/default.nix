{ stdenv, fetchgit, cmake, catch2, indentlog, xo_cmake }:

stdenv.mkDerivation rec {
  name = "randomgen";

  src = fetchgit {
    url = "https://github.com/rconybea/randomgen";
    rev = "748c7d86e42af77b56436fae6607f98384c26945";
    sha256 = "t2kbLpMYmw9k6OuipKFylBLQR3GFaG+P5yWV6ITyCGA=";
  };

  cmakeFlags = ["-DCMAKE_MODULE_PATH=${xo_cmake}/share/cmake"];

  buildInputs = [ indentlog
                  cmake
                  catch2
                  xo_cmake
                ];
}
