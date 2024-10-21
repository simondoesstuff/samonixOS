{inputs, ...}:
let
  inherit (inputs) nix-darwin home-manager;
in
# with inputs;
	nix-darwin.lib.darwinSystem {
			system = "aarch64-darwin";
			# system = "x86_64-darwin";
			specialArgs = { inherit inputs; };
      modules = [ 
				./configuration.nix
				home-manager.darwinModules.home-manager { 
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.mason = {...}: {
						imports = [./temphome.nix ../../modules/darwin/default.nix];
					};

					home-manager.extraSpecialArgs = {
						masonpkgs = import ../../masonpkgs {
							pkgs = import inputs.nixpkgs {system = "aarch64-darwin";};
						};
						username = "mason";
						root = ../..;
					};
				}
			];
			# specialArgs = { inherit inputs; };
  }
