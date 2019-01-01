{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) callPackage;
in

rec {
  riot-desktop = callPackage riot-src {};
  riot-src = callPackage ./pkgs/riot-src.nix {};
  night-light-slider = callPackage ./pkgs/night-light-slider {};
}
