{
  config,
  lib,
  system,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.settings = {
      binds =
        with config.lib.niri.actions;
        let
          sh = spawn "sh" "-c";
        in
        {
          "Mod+Q".action = close-window;
          "Mod+Shift+Q".action = quit;

          "Mod+Return".action.spawn = "kitty";
          "Mod+N".action.spawn = "neovide";
          "Mod+W".action.spawn = "zen";
          "Mod+A".action.spawn = [
            "${getExe config.programs.rofi.package}"
            "-show"
            "drun"
            "-n"
          ];

          "Mod+F".action = toggle-window-floating;
          "Mod+Space".action = toggle-column-tabbed-display;

          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action = focus-column-left;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+left".action = move-column-left;
          "Mod+Ctrl+Down".action = move-window-down;
          "Mod+Ctrl+Up".action = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+L".action = move-column-right;

          "Mod+J".action = focus-window-or-workspace-down;
          "Mod+K".action = focus-window-or-workspace-up;
          "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
          "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;

          "Mod+U".action = focus-column-first;
          "Mod+I".action = focus-column-last;
          "Mod+Ctrl+Home".action = move-column-to-first;
          "Mod+Ctrl+End".action = move-column-to-last;

          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;

          "Mod+C".action = center-column;

          "Mod+Shift+1".action.move-window-to-workspace = 1;
          "Mod+Shift+2".action.move-window-to-workspace = 2;
          "Mod+Shift+3".action.move-window-to-workspace = 3;
          "Mod+Shift+4".action.move-window-to-workspace = 4;
          "Mod+Shift+5".action.move-window-to-workspace = 5;
          "Mod+Shift+6".action.move-window-to-workspace = 6;
          "Mod+Shift+7".action.move-window-to-workspace = 7;
          "Mod+Shift+8".action.move-window-to-workspace = 8;
          "Mod+Shift+9".action.move-window-to-workspace = 9;
          "Mod+Shift+0".action.move-window-to-workspace = 10;

          "Mod+1".action.focus-workspace = 1;
          "Mod+2".action.focus-workspace = 2;
          "Mod+3".action.focus-workspace = 3;
          "Mod+4".action.focus-workspace = 4;
          "Mod+5".action.focus-workspace = 5;
          "Mod+6".action.focus-workspace = 6;
          "Mod+7".action.focus-workspace = 7;
          "Mod+8".action.focus-workspace = 8;
          "Mod+9".action.focus-workspace = 9;
          "Mod+0".action.focus-workspace = 10;

          "Mod+Shift+H".action.set-column-width = "-5%";
          #"Mod+Shift+L".action.set-column-width = "+5%";

          "Print".action = sh "flameshot gui";
          "Mod+S".action = screenshot;
          "Ctrl+Print".action.screenshot-screen = {
            write-to-disk = false;
          };
          "Alt+Print".action.screenshot-window = {
            write-to-disk = false;
          };

          "Mod+Shift+L".action.spawn = "hyprlock";
        };
    };
  };
}
