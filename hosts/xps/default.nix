{inputs, ...}:
let
  inherit (inputs) nixpkgs home-manager nixpkgs-unstable;

	pkgs = import nixpkgs {
    system = "x86_64-linux";
    overlays = [(import ../../overlays/masonpkgs)];
		config = {
			allowUnfree = true;
		};
  };
in
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";

    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.mason = {...}: {
          imports = [./temphome.nix ../../modules/linux/default.nix];
        };

        home-manager.extraSpecialArgs = {
					inherit pkgs;
          username = "mason";
          root = ../..;
					pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";};
        };
      }
    ];
  }
