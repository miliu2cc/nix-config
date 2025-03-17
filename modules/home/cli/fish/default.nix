{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
with lib;
let
  cfg = config.cli.fish;
in
{
  options.cli.fish = {
    enable = mkEnableOption "zsh config";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
    };
  };
}
