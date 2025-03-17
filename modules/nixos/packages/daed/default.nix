{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.daed;
in
{
  options.packages.daed = {
    enable = mkEnableOption "Enable daed packages";
  };

  config = mkIf cfg.enable {
    services.daed = {
      enable = true;

      openFirewall = {
        enable = true;
        port = 12345;
      };
    };
  };
}
