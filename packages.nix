{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # base packages
    wget
    unstable.alacritty
    unstable.git
    unstable.skim
    unstable.fd

    # browsing
    unstable.firefox

    # social
    unstable.element-desktop

    # sdks
    unstable.rustup
    unstable.tectonic
    unstable.clang

    # editors
    neovim-lihram
    
    # Language servers
    texlab
    rnix-lsp

    # Tweaks
    gnome3.dconf-editor
  ];
}
