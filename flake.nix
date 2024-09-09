{
  description = "Home Manager configuration of mason";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    masonpkgs.url = "path:./masonpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    packages.x86_64-linux.homeConfigurations = {
      mason = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          username = "mason";
        };

        modules = [./home.nix ./hosts/linux/default.nix];
      };

      # Profile used for OS VM
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {
          username = "user";
        };

        modules = [./home.nix ./hosts/linux/os_class/default.nix];
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
        };

        modules = [./home.nix ./hosts/darwin/default.nix];
      };
    };
  };
}
