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
    zen.enable = mkOpt types.bool false "Enable zen kernel";
  };
  config = {
    # chaotic.nyx.overlay.enable = true;
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    #boot.extraModulePackages = [config.boot.kernelPackages.acpi_call];
    #boot.kernelParams = ["acpi_call"];
  };
}
