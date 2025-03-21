{
  description = "doomsday nix configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixvim.url = "github:nix-community/nixvim/main";
    systems.url = "github:nix-systems/default";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs =
    { ... }@inputs:
    rec {
      # To load a nixos config with home-manager built into it run
      # sudo nixos-rebuild switch --flake .#hostname
      nixosConfigurations = {
        wslOnix = import ./hosts/wslOnix { inherit inputs; };
        xpsOnix = import ./hosts/xpsOnix { inherit inputs; };
      };

    # To load a home-manager config isolated from the nixos config, these can be used.
    # home-manager switch --flake .#user@hostname
    # TODO: error on home-manager news evoked when using these. Same as:
    # https://discourse.nixos.org/t/news-json-output-and-home-activationpackage-in-home-manager-switch/54192
    packages.x86_64-linux.homeConfigurations = {
      "simon@wsl" = nixosConfigurations.wslOnix.config.home-manager.users."simon".home;
      "simon@xps" = nixosConfigurations.xpsOnix.config.home-manager.users."simon".home;
    };

    # Config for aarch-darwin based home-manager configs used currently on macbook
    # home-manager switch --flake .#user@hostname
    packages.aarch64-darwin.homeConfigurations = {
      simon = import ./hosts/masonmac {inherit inputs;};
    };
  };
}
