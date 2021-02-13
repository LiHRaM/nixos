{ pkgs, ...}:
{
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "Terminus" ]; })
    inter
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "FiraCode Nerd Font Mono"
  ];

  fonts.fontconfig.defaultFonts.sansSerif = [
    "Inter"
  ];
}
