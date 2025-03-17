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
        xserver.displayManager.gdm.enable = true;
        xserver.displayManager.gdm.wayland = true;
    };
  };
}
