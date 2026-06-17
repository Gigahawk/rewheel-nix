{
  self,
  moduleWithSystem,
  ...
}:
{
  flake =
    { config, ... }:
    {
      nixosModules.default = moduleWithSystem (
        perSystem@{ config, system }:
        nixos@{
          config,
          lib,
          pkgs,
          ...
        }:
        let
          moduleName = "rewheel-web";
          serviceDesc = "OneWheel firmware modification tool";
          cfg = config.services.${moduleName};
          inherit (lib)
            mkEnableOption
            mkOption
            mkPackageOption
            mkIf
            types
            ;
        in
        {
          options.services.${moduleName} = {
            enable = mkEnableOption serviceDesc;

            host = mkOption {
              description = "Host address";
              type = types.str;
              default = "::";
            };

            package = mkPackageOption self.packages.${system} "default" { };

            port = mkOption {
              description = "Host port";
              type = types.int;
              # NOTE: 5173 is the default dev server port for vite
              default = 5174;
            };

            extraOptions = mkOption {
              description = "Extra options to pass to static-web-server";
              type =
                with lib.types;
                let
                  scalar = oneOf [
                    bool
                    int
                    str
                  ];
                  attrs = attrsOf scalar;
                in
                coercedTo attrs (lib.cli.toCommandLineGNU { }) (listOf str);
              default = {
                "log-level" = "debug";
              };
            };

            serviceUser = mkOption {
              description = "User to run the service under";
              type = types.str;
              default = "${moduleName}-user";
            };
          };
          config = mkIf cfg.enable {
            users.users.${cfg.serviceUser} = {
              group = cfg.serviceUser;
              isSystemUser = true;
              description = "${moduleName} service user";
            };

            users.groups.${cfg.serviceUser} = { };
            systemd = {
              services.${moduleName} = {
                description = serviceDesc;
                wantedBy = [ "multi-user.target" ];
                after = [
                  "network-online.target"
                ];
                wants = [ "network-online.target" ];

                serviceConfig = {
                  User = cfg.serviceUser;
                  Group = cfg.serviceUser;

                  ExecStart = ''
                    ${cfg.package}/bin/rewheel-web \
                      --host ${cfg.host} \
                      --port ${toString cfg.port} \
                      ${lib.concatStringsSep " " cfg.extraOptions}
                  '';
                };
              };
            };
          };
        }
      );

    };
}
