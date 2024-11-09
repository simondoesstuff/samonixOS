{
  description = "doomsday nix configuration";

  inputs = {
    # TODO: Upgrade to 24.11 and transition yazi when mac swift is fixed upstream
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {...} @ inputs: rec {
    # To load a nixos config with home-manager built into it run
    # sudo nixos-rebuild switch --flake .#hostname
    nixosConfigurations = {
      wsl = import ./hosts/wsl {inherit inputs;};
      xps = import ./hosts/xps {inherit inputs;};
    };

    # To load a home-manager config isolated from the nixos config, these can be used.
    # home-manager switch --flake .#user@hostname
    packages.x86_64-linux.homeConfigurations = {
      "mason@wsl" = nixosConfigurations.wsl.config.home-manager.users."mason".home;
      "mason@xps" = nixosConfigurations.xps.config.home-manager.users."mason".home;
    };

    # Config for aarch-darwin based home-manager configs used currently on macbook
    # home-manager switch --flake .#user@hostname
    packages.aarch64-darwin.homeConfigurations = {
      mason = import ./hosts/masonmac {inherit inputs;};
    };
  };
}
