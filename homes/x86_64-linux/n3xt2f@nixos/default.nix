{
  lib,
  config,
  pkgs,
  username,
  hostname,
  stateVersion,
  ...
}:
with lib;
{
  xdg.enable = true;
  snowfallorg.user.name = username;
  programs.home-manager.enable = true;
  home.stateVersion = stateVersion;


  apps.kitty.enable = true;
  apps.socialMidia.enable = true;
  apps.sql.enable = true;
  cli.yazi.enable = true;
  cli.fish.enable = true;
  cli.neovim.enable = true;
  cli.nvim.enable = true;
  env.enable = true;
  hypr = {
    hyprland = {
      enable = true;
      hostname = hostname;
      barcmd = "waybar &";
      #menucmd = "tofi-drun";
    };
    hyprlock.enable = true;
    hypridle.enable = true;
    pyprland.enable = true;
    wlogout.enable = true;
  };
  niri.enable = true;
  waybar.enable = true;
  scripts = {
    dmenucmd = "tofi";
    # dmenucmd = "${pkgs.rofi-wayland}/bin/rofi";
    basic.enable = true;
    wayland.enable = true;
    x11.enable = false;
    #autobisync-service.enable = true;
  };

  tools = {
    fcitx5.enable = true;
    tofi.enable = true;
    direnv.enable = true;
    rofi.enable = true;
    stylix.enable = true;
    stylix.hostname = hostname;
  };
}

