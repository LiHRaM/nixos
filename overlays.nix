{
  nixpkgs.overlays = [
    (import ./overlays/neovim-lihram.nix)
  ];
}
