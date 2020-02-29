{ stdenv, lib, fetchFromGitHub, makeWrapper, perl, perlPackages, coreutils,
  busybox, sudo, openssh, pv, gzip, pigz, zstd, xz, lzop, lz4, mbuffer }:

let
  path = lib.makeBinPath [
    coreutils
    busybox
    sudo
    openssh
    pv
    gzip
    pigz
    zstd
    xz
    lzop
    lz4
    mbuffer
  ];

  perlPath = with perlPackages; makePerlPath [
    CaptureTiny
  ];
in

stdenv.mkDerivation rec {
  name = "syncoid-${version}";
  version = "2020-01-18";

  src = fetchFromGitHub {
    owner = "jimsalterjrs";
    repo = "sanoid";
    rev = "bb30496d19affedace5180e282f37b39c151ac84";
    sha256 = "0lbjgcczsd8l6rvq99x2dbf7wm8q661aqsxdwbcfx8c05afyrg18";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/syncoid $out/bin
  '';

  fixupPhase = ''
    substituteInPlace $out/bin/syncoid --replace "/usr/bin/perl" "${perl}/bin/perl"
    substituteInPlace $out/bin/syncoid --replace "/bin:/usr/bin:/sbin" "${path}"
    wrapProgram $out/bin/syncoid --set PERL5LIB "${perlPath}"
  '';
}
