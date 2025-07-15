{config, pkgs, lib, inputs, ...}:
with lib;
let
  cfg = config.ags;
in
{
  options.ags = with types; {
    enable = mkEnableOption "enable ags shell";
  };


  config = mkIf cfg.enable {
    imports = [ inputs.ags.homeManagerModules.default ];

      programs.ags = {
        enable = true;
        configDir = null;  # Don't symlink since we're using the bundled version
        extraPackages = with pkgs; [
          inputs.astal-shell.packages.${pkgs.system}.default
        ];
      };
  }
}
