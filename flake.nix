{
  description = "doomsday nix configuration";

  inputs = {
    # TODO: Upgrade to 24.11 and transition yazi when mac swift is fixed upstream
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    masonpkgs.url = "path:./masonpkgs";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    masonpkgs.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-wsl,
    ...
  }: {
    nixosConfigurations = {
      "mason@wsl" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit nixos-wsl;};
        modules = [
          ./nixos/wsl.nix
        ];
      };
    };

    packages.x86_64-linux.homeConfigurations = {
      mason = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          username = "mason";
          root = ./.;
        };

        modules = [./home.nix ./hosts/linux/default.nix];
      };

      # Profile used for OS VM
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          username = "user";
          root = ./.;
        };

        modules = [./home.nix ./hosts/linux/os_vm.nix];
      };
    };

    packages.aarch64-darwin.homeConfigurations = {
      mason = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "aarch64-darwin";};

        extraSpecialArgs = {
          masonpkgs = import ./masonpkgs {
            pkgs = import nixpkgs {system = "aarch64-darwin";};
          };
          username = "mason";
          root = ./.;
        };

        modules = [./home.nix ./hosts/darwin/masonmac.nix];
      };
    };
  };
}
