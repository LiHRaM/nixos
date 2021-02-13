{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.services.ums;
in
  {
    options = {
      services.ums = {
        enable = mkEnableOption "Universal Media Server";

        dataDir = mkOption {
          type = types.str;
          default = "/var/lib/ums";
          description = ''
            The directory where Universal Media Server stores its data files.
          '';
        };

        openFirewall = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Open ports in the firewall for the media server.
          '';
        };

        user = mkOption {
          type = types.str;
          default = "ums";
          description = ''
            User account under which Universal Media Server runs.
          '';
        };

        group = mkOption {
          type = types.str;
          default = "ums";
          description = ''
            Group under which Universal Media Server runs.
          '';
        };

        package = mkOption {
          type = types.package;
          default = pkgs.ums;
          defaultText = "pkgs.ums";
          description = ''
            The Universal Media Server package to use.
          '';
        };

      };
    };
    config = mkIf cfg.enable {

      systemd.services.ums = {
        description = "Universal Media Server";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "simple";
          User = cfg.user;
          Group = cfg.group;

          ExecStartPre = let
            script = pkgs.writeScript "ums-run-prestart" ''
              #!${pkgs.bash}/bin/bash

              if ! test -d "${cfg.dataDir}"; then
                echo "Creating initial UMS data directory in ${cfg.dataDir}"
                install -d -m 0755 -o "${cfg.user}" -g "${cfg.group}" "${cfg.dataDir}"
              fi
            '';
          in
          "!${script}";

          ExecStart = "${cfg.package}/bin/ums";
          KillSignal = "SIGQUIT";
          Restart = "on-failure";
        };

        environment = {
          UMS_PROFILE = "${cfg.dataDir}/UMS.conf";
        };
      };

      networking.firewall = mkIf cfg.openFirewall {
        allowedTCPPorts = [ 1900 5001 9001 ];
        allowedUDPPorts = [ 1900 ];
      };

      users.users = mkIf (cfg.user == "ums") {
        ums = {
          group = cfg.group;
        };
      };

      users.groups = mkIf (cfg.group == "ums") {
        ums = {
          gid = config.ids.gids.ums;
        };
      };
    };
  }
