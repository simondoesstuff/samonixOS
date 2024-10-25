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
  # TODO: Come up with a cleaner way to pass nixpkgs-unstable and other extraSpecialArgs to home-manager
  # Probably a global config defined out here that gets inherited alongside inputs

  outputs = {
    nixpkgs, # TODO: Remove when home-manager confs below are isolated and pass inputs instead
    home-manager, # TODO: Remove when home-manager confs below are isolated and pass inputs instead
    ...
  } @ inputs: rec {
    # To load a nixos config with home-manager built into it run
    # sudo nixos-rebuild switch --flake .#user@hostname
    nixosConfigurations = {
      "mason@wsl" = import ./hosts/wsl {inherit inputs;};
      "mason@xps" = import ./hosts/xps {inherit inputs;};
    };

    # To load a home-manager config isolated from the system config, these can be used.
    # home-manager switch --flake .#user@hostname
    packages.x86_64-linux.homeConfigurations = {
      # TODO: Home-manager CLI is not available on nixos configs yet
      "mason@wsl" = nixosConfigurations."mason@wsl".config.home-manager.users."mason".home;
      "mason@xps" = nixosConfigurations."mason@xps".config.home-manager.users."mason".home;

      # Profile used for OS VM
      # TODO: Remove at end of semester
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          username = "user";
          root = ./.;
        };

        modules = [./home.nix ./hosts/linux/os_vm.nix];
      };
    };

    # Config for aarch-darwin based home-manager configs used currently on macbook
    packages.aarch64-darwin.homeConfigurations = {
      mason = import ./hosts/masonmac {inherit inputs;};
    };
  };
}
