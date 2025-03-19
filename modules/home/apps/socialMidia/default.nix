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
  cfg = config.apps.socialMidia;
in
{
  options.apps.socialMidia = {
    enable = mkOpt types.bool false "Enable alacritty terminal";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs;[
      wechat-uos
      qq
    ];
  };
}
