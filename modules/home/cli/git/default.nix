{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.dotfiles;
let
  cfg = config.cli.git;
in
{
  programs.git = {
    enable = true;
    userName = "miliu2cc";
    userEmail = "miliu2cc@gmail.com";
  };
}
