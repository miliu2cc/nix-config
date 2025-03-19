{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.niri;
in {
  options.desktop.niri = {
    enable = mkEnableOption "Enable niri";
  };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };
  };
}
