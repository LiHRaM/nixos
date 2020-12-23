{
  nixpkgs.overlays = [
    (import ./overlays/neovim-with-plugins.nix)
  ];
}
