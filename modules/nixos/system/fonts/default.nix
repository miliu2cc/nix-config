{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.dotfiles;
let

  nerdFonts = with pkgs.nerd-fonts; [
    # fonts name can get in `https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix`
    hack
    jetbrains-mono
    iosevka
    daddy-time-mono
    symbols-only
  ];
  cfg = config.system.fonts;
in
{
  options.system.fonts = with types; {
    enable = mkOpt types.bool true "Enable font settings";
  };

  config = mkIf cfg.enable {

    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          
        emoji = ["Noto Color Emoji"];

        serif = [
          "Maple Mono NF CN"
          "Noto Serif CJK SC"
          "Noto Serif"
        ];
        sansSerif = [
          "Maple Mono NF CN"
          "Noto Sans CJK SC"
          "Moto Sans"
        ];
        monospace = [
          "Maple Mono NF CN"
          "Noto Sans Mono CJK SC"
        ];
        };
        
      };

      #

      packages = with pkgs; [
        material-symbols
        material-icons
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-color-emoji
        maple-mono-NF
      ]
      ++ nerdFonts;
    };
  };
}
