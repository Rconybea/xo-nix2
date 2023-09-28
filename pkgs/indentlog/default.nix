{ stdenv, fetchgit, cmake, catch2, xo_cmake }:

stdenv.mkDerivation rec {
  name = "indentlog";

  src = fetchgit {
    url = "https://github.com/rconybea/indentlog";
    rev = "27c4535bf6b7b11eb8529b4066ff67132772612b";
    sha256 = "GJtyiuz5EysWj9xzz3KCZCjLw/YoNebHfSZthevdNeI=";
  };

  buildInputs = [ cmake
                  catch2
                  xo_cmake
                ];
}
