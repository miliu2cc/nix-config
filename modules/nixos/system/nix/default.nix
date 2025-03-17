{
  options,
  config,
  lib,
  pkgs,
  stateVersion,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.system.nix;
in
{
  options.system.nix = {
    enable = mkOpt types.bool true "Enable nix defaults";
  };

  config = mkIf cfg.enable {

    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        #"https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://mirrors.cernet.edu.cn/nix-channels/store"
      ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    # Optimize storage and automatic scheduled GC running
    # If you want to run GC manually, use commands:
    # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
    # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
    # `nix-collect-garbage -d` for deleting old generations of user profiles
    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    home-manager = {
      backupFileExtension = "backup";
    };
    
    system.stateVersion = stateVersion; # Did you read the comment?
  };
}
