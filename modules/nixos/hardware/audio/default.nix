{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.hardware.audio;
in
{
  options.hardware.audio = with types; {
    enable = mkOpt types.bool true "Enable audio config";
  };

  config = mkIf cfg.enable {

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

  };
}
