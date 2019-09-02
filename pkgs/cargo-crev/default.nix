{ stdenv, fetchFromGitHub, rustPlatform, pkgconfig, openssl }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-crev";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "crev-dev";
    repo = "cargo-crev";
    rev = "v${version}";
    sha256 = "1d1lnnd67fnn2q6pvh8q4rk4j1g7v6pn3db11xqpaqc8r33404xc";
  };

  cargoSha256 = "0mi3yaij17655ix7f8blrsi39z2rzy10px2fajkb5gmhqcsk7hnd";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl ];

  meta = with stdenv.lib; {
    description = "Scalable, social, Code REView system that we desperately need - Rust/cargo frontend";
    homepage = https://github.com/dpc/crev;
    license = with licenses; [ asl20 mit mpl20 ];
    maintainers = [ maintainers.ejpcmac ];
    platforms = platforms.all;
  };
}
