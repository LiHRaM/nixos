self: super:
{
  neovim-lihram = super.neovim.override {
    viAlias = true;
    vimAlias = true;
    configure = {
      packages.myPlugins = with super.vimPlugins; {
        start = [
          vim-sensible
          vim-lastplace
          vim-devicons
          vim-nix
          lightline-vim
          skim-vim
        ];
        opt = [];
      };

      customRC = ''
        " Reasonable tabs
        set tabstop=8
        set softtabstop=0
        set shiftwidth=4
        set expandtab
        set smarttab
        set autoindent
        " Show numbers
        set number
        set fileencoding=UTF-8
        set nobackup
        set nowritebackup
        set noswapfile

        " Use the real clipboard
        set clipboard+=unnamedplus


        " Mappings
        let mapleader = ","
        map <space> /
        map <C-space> ?

        " Clear search highlight
        map <silent> <leader><cr> :let @/ = ""<cr>
      '';
    };
  };
}

