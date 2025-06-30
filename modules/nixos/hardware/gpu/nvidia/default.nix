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
    };
    services.xserver.videoDrivers = ["nvidia" "modesetting"];
    hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
            offload.enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = false;
    };

  };
}
