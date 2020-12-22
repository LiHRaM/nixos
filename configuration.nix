{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in {
  imports = [
    ./hardware-configuration.nix
    ./neovim-with-plugins.nix
    ./fonts.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    channel = https://nixos.org/channels/nixos-20.09;
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

  services.xserver.layout = "dk";
  services.xserver.enable = true;
  services.xserver.desktopManager.pantheon = {
    enable = true;
    extraGSettingsOverridePackages = with pkgs; [ pantheon.elementary-settings-daemon ];
    extraGSettingsOverrides = ''
      [apps/light-locker]
      idle-hint=false
      late-locking=true
      lock-after-screensaver=uint32 5
      lock-on-lid=true
      lock-on-suspend=true

      [io/elementary/desktop/wingpanel/bluetooth]
      bluetooth-enabled=false

      [io/elementary/desktop/wingpanel/power]
      show-percentage=true

      [io/elementary/terminal/settings]
      natural-copy-paste=false
      prefer-dark-style=true

      [net/launchpad/plank/docks/dock1]
      theme='Matte'

      [org/gnome/desktop/applications/terminal]
      exec='alacritty'

      [org/gnome/desktop/interface]
      document-font-name='sans 10'
      font-name='sans 10'
      monospace-font-name='monospace 10'

      [org/gnome/desktop/peripherals/mouse]
      natural-scroll=false

      [org/gnome/desktop/peripherals/touchpad]
      natural-scroll=true

    '';
  };
  services.xserver.displayManager.lightdm.greeters.pantheon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

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

    # language servers
    texlab

    # editors
    neovim-with-plugins
    unstable.vscode

    # Tweaks
    gnome3.dconf-editor
  ];

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

  # For applications which should be bleeding edge
  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.flatpak.enable = true;
  
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

