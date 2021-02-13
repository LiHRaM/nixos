{ ... }:
{
  imports = [ 
    ./overlays.nix
    ./packages.nix
    ./profiles/default.nix
    ./modules/default.nix
    ./hosts/default.nix
  ];

  nixpkgs.overlays = [
    (import ./overlays/neovim-lihram.nix)
  ];
}
