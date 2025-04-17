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
    
  };
}
