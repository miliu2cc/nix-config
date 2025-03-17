{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.zen-browser;
in
{
  options.packages.zen-browser = {
    enable = mkEnableOption "Enable daed packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inputs.zen-browser.packages.x86_64-linux.beta
    ];
  };
}
