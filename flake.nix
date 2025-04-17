{
  description = "Why?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    # nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11"; # Pin stable for nerdfonts
    # nixpkgs-limefix.url = "github:nixos/nixpkgs?rev=efabdd83aaa48154cb63515771c435f36adb7d24";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    daeuniverse.url = "github:daeuniverse/flake.nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nvimdots.url = "github:ayamir/nvimdots";


    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    pyprland.url = "github:hyprland-community/pyprland";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix.url = "github:niksingh710/nvix";
  };

  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {

      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "idk";
          title = "huh";
        };
        namespace = "dotfiles";
      };

      channels-config = {
        allowUnfree = true;
      };

      # Host-specific settings:
      systems.hosts.nixos.specialArgs = {
        hostname = "nixos";
        stateVersion = "24.11";
      };

      overlays = with inputs; [
        niri.overlays.niri
      ];

      # Home modules:
      home.modules = with inputs; [
        stylix.homeManagerModules.stylix
        niri.homeModules.niri
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            daeuniverse.nixosModules.dae
            daeuniverse.nixosModules.daed
            niri.nixosModules.niri
          ];
        };
      };

      # Home-specific settings:
      homes.users."n3xt2f@nixos".specialArgs = {
        hostname = "nixos";
        username = "n3xt2f";
        stateVersion = "24.11";
      };
    };
}
