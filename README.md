# nix-jpc

Personal Nix channel. **Please use with caution, nothing here is guarenteed to
keep working.**

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
  home.packages = [ jpc.syncoid ];
}
```
