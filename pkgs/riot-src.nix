##
## riot-electron-nix seems to work only if node/generate.sh has been run
## previously. This derivation builds automatically a source package that works.
## This is an ugly hack, but for now it works.
##

{ stdenv, fetchFromGitHub, callPackage, nix, git, nodejs-8_x }:

stdenv.mkDerivation rec {
  name = "riot-src-${version}";
  version = "0.17.2";

  src = fetchFromGitHub {
    owner = "Ralith";
    repo = "riot-electron-nix";
    rev = "3a3984c6f96de54d57198fe897bdd6270acb3245";
    sha256 = "1ivscmc2vkqpmhw31736wawf9fyr8js89m44sgbgd35wlf6npvsy";
    fetchSubmodules = true;
  };

  buildInputs = [
    nix # HACK: node2nix needs Nix. This is ugly.
    git # HACK: this is ugly too.
    nodejs-8_x
    (callPackage "${src}/node/node2nix.nix" {})
  ];

  buildPhase = ''
    HOME="$PWD"

    pushd riot-web
    npm install
    npm shrinkwrap --dev
    popd

    pushd node
    rm -f default.nix node-packages.nix node-env.nix
    node2nix \
    --development \
    --nodejs-8 \
    --input node-packages.json \
    --composition default.nix \
    --node-env node-env.nix \
    --lock ../riot-web/npm-shrinkwrap.json
    popd
  '';

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out
  '';
}
