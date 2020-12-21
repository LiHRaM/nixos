{ pkgs, ...}:
{
  environment.variables = {
    EDITOR = "nvim";
  };

  nixpkgs.overlays = [
    (self: super: {
      neovim-with-plugins = super.neovim.override {
        viAlias = true;
        vimAlias = true;

        configure = {
          packages.myPlugins = with pkgs.vimPlugins; {
            start = [
              vim-sensible
              vim-airline
              vim-lastplace
              vim-nix
            ];
            opt = [];
          };
          customRC = ''
            set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
            set number
          '';
        };
      };
    })
  ];
}
