{ config, pkgs, options, ... }:
{
  imports = [
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./elementary.nix
    ./fonts.nix
    ./overlays.nix
    ./packages.nix
    ./laptop.nix
    ./jellyfin.nix
  ];
  
  home-manager.useGlobalPkgs = true;


  environment.variables = {
    EDITOR = "nvim";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "saga"; # Define your hostname.
  networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  time.timeZone = "Europe/Copenhagen";

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.lihram = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ]; 
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?
}

