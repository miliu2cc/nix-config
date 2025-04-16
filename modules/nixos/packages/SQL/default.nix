
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
    enable = mkEnableOption "Enable daed packages";
  };

  config = mkIf cfg.enable {
    services.SQL = {
      enable = true;
      packages = pkgs.mariadb;
    };
  };
}
