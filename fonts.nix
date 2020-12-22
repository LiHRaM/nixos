{ pkgs, ...}:
{
  fonts.fonts = with pkgs; [
    cascadia-code
    inter
  ];

  fonts.fontconfig.defaultFonts.monospace = [
    "Cascadia Code PL"
  ];
  fonts.fontconfig.defaultFonts.sansSerif = [
    "Inter"
  ];
}
