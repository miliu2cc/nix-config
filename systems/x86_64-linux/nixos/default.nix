{
  lib,
  pkgs,
  inputs,
  # Additional metadata is provided by Snowfall Lib.
  namespace, # The namespace used for your flake, defaulting to "internal" if not set.
  system, # The system architecture for this host (eg. `x86_64-linux`).
  target, # The Snowfall Lib target for this system (eg. `x86_64-iso`).
  format, # A normalized name for the system target (eg. `iso`).
  virtual, # A boolean to determine whether this system is a virtual target using nixos-generators.
  systems, # An attribute map of your defined hosts.
  # All other arguments come from the system system.
  config,
  hostname,
  ...
}: {
  imports = [./hardware-configuration.nix];

  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;

  displayManager = {
    gdm.enable = true;
  };

  desktop = {
    gnome.enable = true;
    hyprland.enable = true;
    niri.enable = true;
    river.enable = true;
  };

  hardware = {
    audio.enable = true;
    bluetooth.enable = true;
    gpu.nvidia.enable = true;
    networking.enable = true;
    networking.hostname = hostname;
  };

  packages = {
    basics.enable = true;
    dev.enable = true;
    gtk.enable = true;
    daed.enable = true;
    zen-browser.enable = true;
  };

  system = {
    boot.enable = true;
    dbus.enable = false;
    fonts.enable = true;
    fcitx5.enable = true;
    kernel.xanmod.enable = true;
    ld.enable = true;
    locale.enable = true;
    nix.enable = true;
  };

  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.n3xt2f = {
    isNormalUser = true;
    # hashedPasswordFile = config.sops.secrets.naim-password.path;
    description = "n3xt2f";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    createHome = true;
    shell = pkgs.fish;
    packages = with pkgs; [kitty];
  };
}
