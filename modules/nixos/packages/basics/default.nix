{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.packages.basics;
in
{
  options.packages.basics = {
    enable = mkOpt types.bool true "Enable basic packages";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      #nix
      nh
      nix-output-monitor
      nvd
      nix-index
      nurl
      nix-ld
      coolercontrol.coolercontrol-gui
      coolercontrol.coolercontrold
      coolercontrol.coolercontrol-liqctld
      dell-command-configure
      #temp
      inputs.nvix.packages.${pkgs.system}.default
      awcc

      # apps:
      obsidian
      hmcl
      onlyoffice-desktopeditors
      lua5_4_compat
      
      #lang
      #rust
      cargo

      #download
      qbittorrent

      #player
      vlc


      # cli:
      starship
      fzf
      fd
      jq
      ripgrep
      tree
      fastfetch
      btop
      lazygit

      # utils:
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      libnotify
      git
      unzip
      bat
    ];
  };
}
