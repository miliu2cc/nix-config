{pkgs, lib, config, ...}:
with lib;
with lib.dotfiles;
let
  cfg = config.tools.fcitx5;
in
{
  options.tools.fcitx5 = {
    enable = mkOpt types.bool false "Enable fctix5";
  };
  config = mkIf cfg.enable {
    home.file = {
      ".config/fcitx5/conf/classicui.conf".source = ./classicui.conf;
      ".local/share/fcitx5/themes/Nord/theme.conf".text = import ./theme.nix;
    };
  };



}
