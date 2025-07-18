{
  description = "A new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

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
    #   awcc.url = "github:miliu2cc/AWCC";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.2-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal-shell.url = "github:knoopx/ags";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        stateVersion = "25.05";
      };

      overlays = with inputs; [
        niri.overlays.niri
      ];

      # Home modules:
      home.modules = with inputs; [
        stylix.homeModules.stylix
        niri.homeModules.niri
        nvimdots.homeModules.nvimdots
        #awcc.homeManagerModules.awcc
        #quickshell.homeModules.quickshell
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            daeuniverse.nixosModules.dae
            daeuniverse.nixosModules.daed
            niri.nixosModules.niri
            lix-module.nixosModules.default
          ];
        };
      };

      # Home-specific settings:
      homes.users."n3xt2f@nixos".specialArgs = {
        hostname = "nixos";
        username = "n3xt2f";
        stateVersion = "25.05";
      };
    };
}
