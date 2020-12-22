{ pkgs, ... }:
{

  services.xserver = {
    enable = true;
    layout = "dk";
    displayManager.lightdm = {
      enable = true;
      greeters.pantheon.enable = true;
    };
    libinput.enable = true;
    desktopManager.pantheon = {
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
  };
}
