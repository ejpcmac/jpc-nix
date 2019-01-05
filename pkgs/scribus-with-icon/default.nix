{ stdenv, scribus, imagemagick }:

stdenv.mkDerivation rec {
  name = "${scribus.name}-with-icon";
  icon = ./icon.svg;

  buildInputs = [ scribus imagemagick ];

  buildCommand = ''
    mkdir -p $out/bin $out/share/applications
    ln -s ${scribus}/bin/scribus $out/bin
    cp ${scribus}/share/applications/scribus.desktop $out/share/applications

    for i in 16 24 48 64 96 128 256 512; do
      mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
      convert -background none -resize ''${i}x''${i} ${icon} $out/share/icons/hicolor/''${i}x''${i}/apps/scribus.png
    done

    substituteInPlace $out/share/applications/scribus.desktop \
      --replace "#MimeType" "MimeType"
  '';
}
