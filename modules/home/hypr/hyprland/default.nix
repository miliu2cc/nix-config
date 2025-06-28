{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.hypr.hyprland;
  hostname = cfg.hostname;
  barcmd = cfg.barcmd;
  menucmd = cfg.menucmd;
in
{
  options.hypr.hyprland = {
    enable = mkOpt types.bool false "Enable Hyprland DE";
    hostname = mkOpt types.str "nixos" "Hostname (used to determine monitor settings)";
    barcmd = mkOpt types.str "waybar &" "Command to start bar. (include &)";
    menucmd = mkOpt types.str "rofi -show drun" "Menu command";
  };

  config = mkIf cfg.enable {
    # source normal config:
    home.file."${config.xdg.configHome}/hypr/binds.conf" = {
      source = ./binds/binds.conf;
    };
    home.file."${config.xdg.configHome}/hypr/animations/animations3.conf" = {
      source = ./animations/animations3.conf;
    };

    home.file."${config.xdg.configHome}/hypr/plugins/hyprexpo.conf" = {
      source = ./plugins/hyprexpo.conf;
    };

    # enable hyprland
    wayland.windowManager.hyprland = {
      # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      plugins = [
        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        #inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
         #inputs.hycov.packages.${pkgs.system}.hycov
      ];
      systemd.enable = true;
      systemd.variables = [ "--all" ];
      xwayland.enable = true;

      settings =
        let
          border = if hostname == "nixos" then "2" else "3";
          outerGaps = if hostname == "nixos" then "10" else "6";
          innerGaps = if hostname == "nixos" then "5" else "3";
          rounding = if hostname == "nixos" then "8" else "4";
          maxFloatW = if hostname == "nixos" then "1920" else "1920";
          maxFloatH = if hostname == "nixos" then "1080" else "1080";
        in
        {
          "$terminal" = "kitty";
          "$fileManager" = "yazi";
          "$menu" = "${menucmd}";
          "$windows" = "rofi -show window";

          exec-once = [
            # "swww-daemon &"
            "hyprshade on vibrance"
            "pypr"
            "waybar &"
            "fcitx5"
          ];

          source = [
            "${config.xdg.configHome}/hypr/binds.conf"
            "${config.xdg.configHome}/hypr/animations/animations3.conf"
            "${config.xdg.configHome}/hypr/plugins/hyprexpo.conf"
          ];

          monitor = [
            "HDMI-A-1,2560x1440@59.95,0x0,1.00"
            # "eDP-1,1366x768@60,auto,1"
            "eDP-1, disable"
          ];
          xwayland = {
            force_zero_scaling = "true";
          };
          input = {
            kb_layout = "us";
            follow_mouse = "1";
            sensitivity = "-0.2";
            touchpad = {
              natural_scroll = "true";
            };
          };
          gestures = {
            workspace_swipe = "true";
            workspace_swipe_fingers = "3";
            workspace_swipe_distance = "100";
          };


          # general = with config.stylix.base16Scheme; {
          general = {
            gaps_in = "${innerGaps}";
            gaps_out = "${outerGaps}";
            border_size = "${border}";
            layout = "master";

            # "col.active_border" = lib.mkForce "rgb(${config.stylix.base16Scheme.base0D})";
            # "col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base03}aa)";
            # "col.active_border" = lib.mkForce "rgba(ffffffff)";

            allow_tearing = "false";
          };

          decoration = {
            rounding = "${rounding}";

            blur = {
              xray = "true";
              enabled = "true";
              size = "4";
              passes = "2";
              new_optimizations = "true";
              ignore_opacity = "true";
            };
            shadow = {
              enabled = false;
              color = lib.mkForce "rgba(1a1a1aee)";
            };
          };

          master = {
            slave_count_for_center_master = "4";
            mfact = 0.6;
            new_on_top = true;
          };

          group = {
            merge_groups_on_drag = "2"; # Only when dropping on group bar
            insert_after_current = false;
          };

          misc = {
            force_default_wallpaper = 0; # Set to 0 to disable the anime mascot wallpapers
            enable_swallow = true;
            swallow_regex = "Alacritty";
            animate_mouse_windowdragging = true;
            vfr = true;
          };

          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "float, class:^(waypaper)$"
            "float, title:^(Sandbox)$"
            "maxsize ${maxFloatW} ${maxFloatH}, class:.*,floating:1"
            "stayfocused, class:(Rofi)"
          ];

          workspace = [
            "special:magic, on-created-empty:webcord, gapsout:20, gapsin:15"
            "special:exposed,gapsout:60,gapsin:30,bordersize:5,border:true,shadow:false"
          ];
        };
    };
  };
}
