
{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.SQL;
in
{
  options.packages.SQL = {
    enable = mkEnableOption "Enable SQl packages";
  };

  config = mkIf cfg.enable {
    services.mysql = {
      enable = true;
      packages = pkgs.mariadb;
    };
  };
}
