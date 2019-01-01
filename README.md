# nix-jpc

Personal Nix channel containing some ugly hacks that will eventually become
something better. In the mean time, **please use with caution, and fork before
using.**

## Usage

First, add the channel:

    $ nix-channel --add https://github.com/ejpcmac/jpc-nix/archive/master.tar.gz jpc-nix
    $ nix-channel --update jpc-nix

You can then install packages from this channel, for instance in your `home.nix`

```nix
{ config, pkgs, ... }:

let
  jpc = import <jpc-nix> { inherit pkgs; };
in

{
  home.packages = [ jpc.riot-desktop ];
}
```
