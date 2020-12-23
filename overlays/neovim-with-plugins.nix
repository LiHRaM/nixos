self: super:
let
  vim-nonsense = super.vimUtils.buildVimPlugin {
    name = "vim-nonsense";
    src = super.fetchFromGitHub {
      owner = "lihram";
      repo = "vim-nonsense";
      rev = "14d3653831cc71300da3400d6bca4b16b7632fb1";
      sha256 = "0726gk0wy2kksmkhjvxg8g9hxkpvpnvys5mv34bhyrk3wxdlx08a";
    };
  };
in {
  neovim-with-plugins = super.neovim.override {
    viAlias = true;
    vimAlias = true;
    configure = {
      packages.myPlugins = with super.vimPlugins; {
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
}

