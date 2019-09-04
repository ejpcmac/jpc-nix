{ stdenv, fetchFromGitHub, rustPlatform, pkgconfig, dbus }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-testify";
  version = "0.2.0";

  src = stdenv.mkDerivation {
    name = "${pname}-${version}-src";

    src = fetchFromGitHub {
      owner = "greyblake";
      repo = "cargo-testify";
      rev = "v${version}";
      sha256 = "1jz91q7xhmkpday2jcpaf12i62s57lwryrp44h83a3zfxxsrf0jn";
    };

    phases = [ "unpackPhase" "buildPhase" ];

    buildPhase = ''
      cat ${./Cargo.lock} > Cargo.lock
      mkdir -p $out
      cp -rv * $out
    '';
  };

  cargoSha256 = "1fd64nrav9iyfqharvl6nq9jlhm2hy7ii3mmrp85w9hvg4hhbjlm";

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ dbus ];

  doCheck = false;

  meta = with stdenv.lib; {
    description = "Tool to automatically run tests on your Rust project and notify about the result.";
    homepage = https://github.com/greyblake/cargo-testify;
    license = licenses.mit;
    maintainers = [ maintainers.ejpcmac ];
    platforms = platforms.all;
  };
}
