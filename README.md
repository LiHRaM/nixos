# LiHRaM/NixOS

These are my NixOS configuration files.

## Channels
This setup relies on the root account having the following channels (naming is important!)
    
    $ sudo nix-channel --list
    home-manager https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz
    nixos https://nixos.org/channels/nixos-20.09
    unstable https://nixos.org/channels/nixpkgs-unstable
