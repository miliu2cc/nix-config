{
  pkgs,
  lib,
  config,
  system,
  inputs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.cli.neovim;
in
{
  options.cli.neovim = {
    enable = mkOpt types.bool false "Enable Neovim Packages";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
    };

    programs.nix-ld.enable = true;

    programs.neovim.nvimdots = {
      enable = true;
      setBuildEnv = true;  # Only needed for NixOS
      withBuildTools = true; # Only needed for NixOS
    };

    programs.dotnet.dev = {
      enabled = true;
      environmentVariables = {
        DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "0";  # Will set environment variables for DotNET.
      };
    };
  };
}
