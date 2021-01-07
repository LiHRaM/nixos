{ ... }:
let
  unstable = import <unstable> {};
in
{
  services.jellyfin = {
    enable = true;
    user = "jellyfin";
    group = "jellyfin";
    package = unstable.jellyfin;
  };

  networking.firewall = {
    allowedTCPPorts = [
      8096
      8920
    ];
    allowedUDPPorts = [
      1900
      7359
    ];
  };
}
