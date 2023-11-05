{ lib, stdenv, rustPlatform, fetchFromGitHub }:
rustPlatform.buildRustPackage rec {
  pname = "openscad-language-server";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "dzhu";
    repo = pname;
    rev = version;
    sha256 = "00msajwwy531ji93xk83lbnbp19asyk1b8ai0hi2awb63vpdr4xg";
  };

  cargoSha256 = "sha256-jsnoDRDIvAQN0UrvR1y0LcWtQ8c0sAy8AAttYEsrRHA=";

  meta = with stdenv.lib; {
    description = "A Language Server Protocol server for OpenSCAD";
    homepage = "https://github.com/dzhu/openscad-language-server";
    # license = licenses.MIT;
  };
}
