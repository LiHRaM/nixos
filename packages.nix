{ pkgs, config, ... }:
let
  unstable = import <unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = https://nixos.org/channels/nixos-20.09;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # base packages
    wget
    unstable.git
    unstable.skim
    unstable.fd
    unstable.kitty

    # browsing
    unstable.firefox

    # social
    unstable.element-desktop

    # sdks
    unstable.rustup
    unstable.clang
    # tectonic-lihram

    # editors
    neovim-lihram
    
    # Language servers
    texlab
    rnix-lsp

    # Tweaks
    gnome3.dconf-editor
  ];
}
