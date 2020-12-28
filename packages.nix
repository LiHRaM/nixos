{ pkgs, config, ... }:
let
  unstable = import <unstable> {};
in
{
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with unstable; [
    # base packages
    pkgs.wget
    git
    skim
    fd
    kitty

    # browsing
    firefox

    # editors
    pkgs.neovim-lihram
  ];
}
