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
      inputs.nvix.packages.${pkgs.system}.default
      inputs.quickshell.packages.${pkgs.system}.default
      gemini-cli

      #temp
      code-cursor-fhs

      # apps:
      #     obsidian
      #lua5_4_compat

      #something fun
      cmatrix
      
      #lang
      #rust
      cargo

      #download

      #player
      #vlc


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
