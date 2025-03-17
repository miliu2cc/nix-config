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
  cfg = config.apps.kitty;
in
{
  options.apps.kitty = {
    enable = mkOpt types.bool false "Enable alacritty terminal";
  };
  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
    };
  };
}
