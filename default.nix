{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) callPackage;
in

rec {
  night-light-slider = callPackage ./pkgs/night-light-slider {};
}
