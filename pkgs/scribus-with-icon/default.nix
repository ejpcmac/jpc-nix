{ stdenv, makeDesktopItem, scribus, imagemagick }:

let
  icon = ./icon.svg;

  desktopItem = makeDesktopItem rec {
      name = "scribus";
      exec = "${name} %f";
      icon = name;
      desktopName = "Scribus";
      mimeType = "application/vnd.scribus";
      categories = "Qt;Graphics;Publishing;";
  };
in

stdenv.mkDerivation {
  name = "${scribus.name}-with-icon";

  buildInputs = [ scribus imagemagick ];

  buildCommand = ''
    mkdir -p $out/bin $out/share/applications
    ln -s ${scribus}/bin/scribus $out/bin
    cp ${desktopItem}/share/applications/scribus.desktop $out/share/applications

    for i in 16 24 48 64 96 128 256 512; do
      mkdir -p $out/share/icons/hicolor/''${i}x''${i}/apps
      convert -background none -resize ''${i}x''${i} ${icon} $out/share/icons/hicolor/''${i}x''${i}/apps/scribus.png
    done
  '';
}
