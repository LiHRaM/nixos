{ config, lib, pkgs, ... }:
with lib;
let
  unstable = import <unstable> {};
  cfg = config.saga.profiles.media-server;
  group = "media";
in
  {
    imports = [
      # <unstable/nixos/modules/services/misc/nzbhydra2.nix>
    ];

    options.saga.profiles.media-server.enable = mkEnableOption "media server configuration";
    config = mkIf cfg.enable {

      services.jellyfin = {
        inherit group;
        enable = true;
        package = unstable.jellyfin;
      };

      networking.firewall = {
        allowedTCPPorts = [
          80
          443
          1900
          8096 # jellyfin
          8920 # jellyfin
        ];
        allowedUDPPorts = [
          1900
          7359
        ];
      };

      services.jackett = {
        inherit group;
        enable = true;
        openFirewall = true;
        package = unstable.jackett;
      };

      services.transmission = {
        inherit group;
        enable = true;
        openFirewall = true;
      };

      services.sonarr = {
        inherit group;
        enable = true;
        openFirewall = true;
      };

      services.bazarr = {
        inherit group;
        enable = true;
        openFirewall = true;
      };

      services.radarr = {
        inherit group;
        enable = true;
        openFirewall = true;
      };

      users.users.media = {
        isNormalUser = true;
        createHome = true;
        home = "/home/media";
        description = "Media server";
      };

      users.groups.media.members = with config.users; with config.services; [ 
        users.media.name
        jackett.user
        nzbget.user
        sonarr.user
        bazarr.user
        transmission.user
        radarr.user
      ];

      saga.services.per-user-vpn = {
        enable = true;
        servers."${group}" = {
          certificate = /etc/secrets/surfshark_udp_ca.pem;
          tls_auth = /etc/secrets/surfshark_udp_tls_auth.pem;
          credentials = {
            username = /etc/secrets/surfshark_username;
            password = /etc/secrets/surfshark_password;
          };
          mark = "0x1";
          protocol = "udp";
          remotes = [
            "dk-cph.prod.surfshark.com 1194"
            "no-osl.prod.surfshark.com 1194"
          ];
          routeTableId = 42;
          users = with config.services; [
            "media" # su media; curl ipify
            jackett.user
            transmission.user
          ];
        };
      };


      # Expose Jellyfin at :80
      services.nginx = 
      let
        jellyfin = "127.0.0.1";
      in {
        enable = true;
        recommendedTlsSettings = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;

        virtualHosts."lihram.duckdns.org" = {
          forceSSL = true;
          enableACME = true;

          locations."/" = {
            proxyPass = "http://${jellyfin}:8096";
          };

          locations."/socket" = {
            proxyPass = "http://${jellyfin}:8096";
            proxyWebsockets = true;
          };
        };
      };

      security.acme.email = "hilmargustafs@gmail.com";
      security.acme.acceptTerms = true;
      networking.nat = {
        enable = true;
      };
    };
  }
