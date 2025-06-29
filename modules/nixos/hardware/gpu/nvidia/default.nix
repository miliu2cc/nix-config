####
# Stolen from:
# https://github.com/IogaMaster/dotfiles/blob/main/modules/nixos/hardware/nvidia/default.nix
# For a normal setup, my old config, or official nix doc 
####
{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.hardware.gpu.nvidia;
in
{
  options.hardware.gpu.nvidia = with types; {
    enable = mkOpt types.bool false "Enable drivers and patches for Nvidia hardware.";
  };

  config = mkIf cfg.enable {
    #GPU
    hardware.graphics = {
        enable = true;
      #driSupport = true;
      #driSupport32Bit = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
      #sync.enable = true;
            offload.enable = true;
            offload.enableOffloadCmd = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false;
        nvidiaSettings = false;
        forceFullCompositionPipeline = true;
    };
    boot.kernelParams = ["modprobe.blacklist=nouveau"];

  };
}
