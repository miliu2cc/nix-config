{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.desktop.river;
in {
  options.desktop.river = {
    enable = mkEnableOption "Enable river";
  };

  config = mkIf cfg.enable {
    programs.river.enable = true;

    environment.systemPackages = [
      pkgs.river-luatile
    ];
  };
}
