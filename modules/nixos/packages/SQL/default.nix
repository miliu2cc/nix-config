
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.sql;
in
{
  options.packages.sql = {
    enable = mkEnableOption "Enable SQl packages";
  };

  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      packages = pkgs.mariadb;
    };
  };
}
