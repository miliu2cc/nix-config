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
  cfg = config.apps.sql;
in
{
  options.apps.sql = {
    enable = mkOpt types.bool false "Enable alacritty terminal";
  };
  config = mkIf cfg.enable {
    
    home.packages = with pkgs; [
        beekeeper-studio
        insomnia
    ];

  };
}
