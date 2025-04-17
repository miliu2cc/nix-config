{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.nvimdots;
in
{
  options.packages.nvimdots = {
    enable = mkOpt types.bool true "Enable misc packages";
  };
  config = mkIf cfg.enable {
    
    programs.nix-ld.enable = true;

    programs.neovim.nvimdots = {
      enable = true;
      setBuildEnv = true;  # Only needed for NixOS
      withBuildTools = true; # Only needed for NixOS
    };
  };
}
