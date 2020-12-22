{ pkgs, ... }:
let
  vim-nonsense = pkgs.vimUtils.buildVimPlugin {
    name = "vim-nonsense";
    src = pkgs.fetchFromGitHub {
      owner = "lihram";
      repo = "vim-nonsense";
      rev = "14d3653831cc71300da3400d6bca4b16b7632fb1";
      sha256 = "0726gk0wy2kksmkhjvxg8g9hxkpvpnvys5mv34bhyrk3wxdlx08a";
    };
  };
in {
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
              vim-devicons
              vim-nonsense
            ];
            opt = [];
          };
        };
      };
    })
  ];
}
