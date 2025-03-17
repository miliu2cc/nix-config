{pkgs, lib, config, ...}:
with lib;
with lib.dotfiles;
let
  cfg = config.system.fcitx5;
in
{
  options.system.fcitx5 = {
    enable = mkOpt types.bool false "Enable fctix5";
  };
  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-gtk
        fcitx5-chinese-addons
        fcitx5-table-extra
        #fcitx5-pinyin-moegirl
        #fcitx5-pinyin-zhwiki
      ];
    };
  };



}
