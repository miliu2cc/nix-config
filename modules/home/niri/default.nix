{config, pkgs, lib, ...}:
with lib;
let
  cfg = config.niri;
in
{
  options.niri = with types; {
    enable = mkEnableOption "enable niri  wm";
  };

  imports = lib.snowfall.fs.get-non-default-nix-files ./.;

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xwayland-satellite
    ];


    programs.niri.settings = {
      environment = {
        GDK_BACKEND = "wayland";
        GSK_RENDERER = "gl";
        NIXOS_OZONE_WL = "1";
        DISPLAY = ":1";
        MOZ_ENABLE_WAYLAND = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        XDG_CURRENT_DESKTOP = "niri";
        XDG_SESSION_TYPE = "wayland";
      };
      
      outputs = {
        "HDMI-A-1" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 120.000;
          };
        };
        "eDP-1" = {
          enable = false;
        };
      };

      spawn-at-startup = [
        {
          command = [
            "xwayland-satellite"
            ":1"
          ];
        }
        {
          command = [
            "fcitx5"
            "-dr"
          ];
        }
        {
          command = [
            "waybar"
          ];
        }
      ];

      layout = {
        default-column-width.proportion = 2.0 / 3.0;
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 2.0 / 3.0; }
          { proportion = 1.0 / 1.0; }
        ];


        gaps = 10;

        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#ca9ee6";
          inactive.color = "#babbf1";
        };

        border = {
          enable = false;
          width = 4;
          active.color = "#e78284";
          inactive.color = "#babbf1";
        };

        always-center-single-column = true;

        # empty-workspace-above-first = true;

        shadow.enable = true;

        tab-indicator = {
          position = "left";
          gaps-between-tabs = 10;

          hide-when-single-tab = true;
          # place-within-column = true;

          # active.color = "red";
        };
      };

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;

      clipboard.disable-primary = true;

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
        warp-mouse-to-focus.enable = true;
      };

      window-rules = [
        {
          geometry-corner-radius = {
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          draw-border-with-background = false;
        }
        {
          matches = [
            { app-id = "^org\.gnome\.Nautilus$"; }
            {
              app-id = "^Bytedance-feishu$";
              title = "图片";
            }
            { title = "flameshot-pin"; }
          ];
          open-floating = true;
        }
        {
          matches = [
            { app-id = "^com\.mitchellh\.ghostty$"; }
            { app-id = "neovide"; }
            { app-id = "^org\.telegram\.desktop$"; }
            { app-id = "Bytedance-feishu"; }
            { app-id = "wechat"; }
          ];
          opacity = 0.9;
        }
      ];

      gestures.dnd-edge-view-scroll = {

        trigger-width = 64;

        delay-ms = 250;

        max-speed = 12000;

      };

      animations = {
        enable = true;
      };
    };

  };
}
