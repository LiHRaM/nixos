{ ... }:
{
  environment.variables = {
    EDITOR = "nvim";
  };

  networking.hostName = "saga"; # Define your hostname.
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = false;
  networking.networkmanager.wifi.backend = "iwd";

  time.timeZone = "Europe/Copenhagen";

  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp3s0.useDHCP = true;

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
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

  services.openssh.enable = true;
  saga.profiles.media-server.enable = true;
}
