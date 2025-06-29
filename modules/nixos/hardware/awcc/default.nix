{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.hardware.awcc;
in
{
  options.hardware.awcc = with types; {
    enable = mkOpt types.bool true "Enable awcc config";
  };

  config = mkIf cfg.enable {

    services.udev.extraRules = 
      "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"187c\", ATTRS{idProduct}==\"0551\", MODE=\"0660\",GROUP=\"plugdev\"";

  };
}
