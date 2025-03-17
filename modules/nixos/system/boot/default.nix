{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.system.boot;
in
{
  options.system.boot = with types; {
    enable = mkOpt types.bool true "Enable boot defaults";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "nodev";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.useOSProber = true;

  };
}
