{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.apps.SQL;
in
{
  options.apps.SQL = {
    enable = mkOpt types.bool false "Enable alacritty terminal";
  };
  config = mkIf cfg.enable {
    services.mysql = {
        enable = true;
        package = pkgs.mariadb;
    };
    
    home.packages = with pkgs; [
        beekeeper-studio
        insomnia
    ];

  };
}
