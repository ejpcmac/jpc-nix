{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "cargo-binutils";
  version = "0.1.6";

  src = stdenv.mkDerivation {
    name = "${pname}-${version}-src";

    src = fetchFromGitHub {
      owner = "rust-embedded";
      repo = "cargo-binutils";
      rev = "v${version}";
      sha256 = "12pz88d7s24h3j6pqgw02fq5x77maf3fa5v6x1r39pwm8hiii8f7";
    };

    phases = [ "unpackPhase" "buildPhase" ];

    buildPhase = ''
      cat ${./Cargo.lock} > Cargo.lock
      mkdir -p $out
      cp -rv * $out
    '';
  };

  cargoSha256 = "0j36gmrji29vni1lc6dzr078352h94fbrqv6b2fksfb6pczndjzp";

  meta = with stdenv.lib; {
    description = "Cargo subcommands to invoke the LLVM tools shipped with the Rust toolchain";
    homepage = https://github.com/rust-embedded/cargo-binutils;
    license = with licenses; [ asl20 mit ];
    maintainers = [ maintainers.ejpcmac ];
    platforms = platforms.all;
  };
}
