{ pkgs, ...}:
{
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    inter
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "FiraCode Nerd Font"
  ];

  fonts.fontconfig.defaultFonts.sansSerif = [
    "Inter"
  ];
}
