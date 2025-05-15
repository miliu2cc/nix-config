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
  cfg = config.cli.nvim;
in
{
  options.cli.nvim = {
    enable = mkOpt types.bool false "Enable Nvim Packages";
  };

  config = mkIf cfg.enable {
  
    programs.neovim = {
      enable = true;
    };


  };
}
