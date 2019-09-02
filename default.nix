{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) callPackage;
in

rec {
  cargo-binutils = callPackage ./pkgs/cargo-binutils {};
  cargo-crev = callPackage ./pkgs/cargo-crev {};
  cargo-watch = callPackage ./pkgs/cargo-watch {};
  night-light-slider = callPackage ./pkgs/night-light-slider {};
  scribus-with-icon = callPackage ./pkgs/scribus-with-icon {};
  syncoid = callPackage ./pkgs/syncoid {};
}
