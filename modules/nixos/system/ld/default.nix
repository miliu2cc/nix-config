{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.system.ld;
in {
  #run unpatched dynamic binaries
  options.system.ld = {
    enable = mkEnableOption "Enable nix-ld";
  };
  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
    ];
  };
}
