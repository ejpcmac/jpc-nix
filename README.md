# nixpkgs-jpc

Personal Nix packages collection.

## Usage

First, add the channel:

    $ nix-channel --add https://github.com/ejpcmac/nixpkgs-jpc/archive/master.tar.gz nixpkgs-jpc
    $ nix-channel --update nixpkgs-jpc

You can then install packages from this channel, for instance in your `home.nix`

```nix
{ config, pkgs, ... }:

let
  jpc = import <nixpkgs-jpc> { inherit pkgs; };
in

{
  home.packages = [ jpc.syncoid ];
}
```
