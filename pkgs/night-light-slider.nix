{ stdenv, fetchFromGitHub, glib }:

stdenv.mkDerivation rec {
  name = "gnome-shell-extension-night-light-slider-${version}";
  uuid = "night-light-slider.timur@linux.com";
  version = "10.0";

  src = fetchFromGitHub {
    owner = "TimurKiyivinski";
    repo = "gnome-shell-night-light-slider-extension";
    rev = "${version}";
    sha256 = "0009r1y5yini0swwla94pxlzwrd9ddy52b0k9ggpysy186p1zjxi";
  };

  buildInputs = [ glib ];

  buildPhase = ''
    glib-compile-schemas night-light-slider.timur@linux.com/schemas/
  '';

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions
    cp -r ${uuid} $out/share/gnome-shell/extensions/
  '';
}
