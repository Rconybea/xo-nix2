{ stdenv, fetchgit, cmake }:

stdenv.mkDerivation rec {
  name = "xo-cmake";

  src = fetchgit {
    url = "https://github.com/rconybea/xo-cmake";
    rev = "d349796363163419026d7ced0f46f3702ba4a2df";
    sha256 = "vak8TfHbHr/lHcZEsB6qjvoVM6xTdlu9EVbQbhJwPrE=";
  };

  buildInputs = [
                  cmake
                ];
}
