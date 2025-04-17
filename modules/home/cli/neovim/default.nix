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


  };
}
