{ config, pkgs, options, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./hosts/default.nix
    ./modules/default.nix
    ./profiles/default.nix
  ];

  home-manager.useGlobalPkgs = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "20.09";
}

