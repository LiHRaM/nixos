{ pkgs, ... }:
{
  imports = [
    ./dconf.nix
  ];

  services.dbus.enable = true;
  services.dbus.packages = with pkgs; [ gnome3.dconf ];

  services.xserver = {
    enable = true;
    layout = "dk";
    displayManager.lightdm = {
      enable = true;
      greeters.pantheon.enable = true;
    };
    libinput.enable = true;
    desktopManager.pantheon.enable = true;
  };
  
  environment.pantheon.excludePackages = [
    pantheon.elementary-code
  ];
}
