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
  options.apps.ghostty = {
    enable = mkOpt types.bool false "Enable ghostty terminal";
  };
  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
    };
  };
}
