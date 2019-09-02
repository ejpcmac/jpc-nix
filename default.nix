{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) callPackage;
in

rec {
  night-light-slider = callPackage ./pkgs/night-light-slider {};
  scribus-with-icon = callPackage ./pkgs/scribus-with-icon {};
  syncoid = callPackage ./pkgs/syncoid {};
}
