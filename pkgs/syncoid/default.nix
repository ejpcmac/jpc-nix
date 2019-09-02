{ stdenv, lib, fetchFromGitHub, perl, coreutils, busybox, sudo, openssh, pv,
  gzip, pigz, zstd, xz, lzop, lz4, mbuffer }:

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
in

stdenv.mkDerivation rec {
  name = "syncoid-${version}";
  version = "2019-04-20";

  src = fetchFromGitHub {
    owner = "jimsalterjrs";
    repo = "sanoid";
    rev = "dd47dd536886dbd77c66ca77e26b2ac4b9a7f759";
    sha256 = "0y6mka5x0bz6rnaib5nmr9f7mjp28lwbl3i9d4vc2gksryqd7wxs";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp $src/syncoid $out/bin
  '';

  fixupPhase = ''
    substituteInPlace $out/bin/syncoid --replace "/usr/bin/perl" "${perl}/bin/perl"
    substituteInPlace $out/bin/syncoid --replace "/bin:/usr/bin:/sbin" "${path}"
  '';
}
