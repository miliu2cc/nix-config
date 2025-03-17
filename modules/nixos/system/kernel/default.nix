{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.system.kernel;
in
{
  # imports = [ inputs.chaotic.nixosModules.default ];
  options.system.kernel = {
    xanmod.enable = mkOpt types.bool false "Enable xanmod kernel";
  };
  config = {
    # chaotic.nyx.overlay.enable = true;
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    boot.extraModulePackages = [config.boot.kernelPackages.acpi_call];
    boot.kernelParams = ["acpi_call"];
  };
}
