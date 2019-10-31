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
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "jimsalterjrs";
    repo = "sanoid";
    rev = "v${version}";
    sha256 = "09cgchhpprr8yyx9kabwz3y7lz9kzn6wfdsqq3zam7c7yck672xa";
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
