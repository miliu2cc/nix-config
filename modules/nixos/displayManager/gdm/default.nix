{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.displayManager.gdm;
in
{
  options.displayManager.gdm = {
    enable = mkEnableOption "Enable gdm";
  };

  config = mkIf cfg.enable {
    services = {
        xserver.enable = true;
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
    };
  };
}
