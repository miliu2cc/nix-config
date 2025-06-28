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
  cfg = config.coolercontrol;
in
{
  options.coolercontrol = {
    enable = mkOpt types.bool false "Enable coolercontrl";
  };
  config = mkIf cfg.enable {
    programs.coolercontrol = {
      enable = true;
      nvidiaSupport = true;
    };
  };
}
