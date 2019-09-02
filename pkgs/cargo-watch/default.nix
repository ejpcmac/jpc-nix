{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-watch";
  version = "7.2.1";

  src = fetchFromGitHub {
    owner = "passcod";
    repo = "cargo-watch";
    rev = "v${version}";
    sha256 = "13zjsypj0ay9xb5j5fhl3yfn57kp2yngl138vmnyfk1h7gjdxpk3";
  };

  cargoSha256 = "1c3h9il3y0swvcdrrqgh5r7di522i1cc8zk1kfmx97chy8bhsqvg";

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Watches over your Cargo project’s source";
    homepage = https://github.com/passcod/cargo-watch;
    license = licenses.cc0;
    maintainers = [ maintainers.ejpcmac ];
    platforms = platforms.all;
  };
}
