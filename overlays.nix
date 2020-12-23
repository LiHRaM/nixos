{
  nixpkgs.overlays = [
    (import ./overlays/neovim-lihram.nix)
    (import ./overlays/tectonic-lihram.nix)
  ];
}
