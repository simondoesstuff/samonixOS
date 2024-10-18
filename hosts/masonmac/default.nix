{inputs, ...}:
# let
#   inherit (inputs) nix-darwin home-manager;
# in
with inputs;
	nix-darwin.lib.darwinSystem {
			system = "x86_64-darwin";
			specialArgs = { };
      modules = [ 
				./configuration.nix
				# home-manager.darwinModules.home-manager { 
				# 	home-manager.useGlobalPkgs = true;
				# 	home-manager.useUserPackages = true;
				# 	home-manager.users.mason = {...}: {
				# 		imports = [./temphome.nix ../../modules/darwin/default.nix];
				# 	};
				#
				# 	home-manager.extraSpecialArgs = {
				# 		username = "mason";
				# 		root = ../..;
				# 	};
				# }
			];
			# specialArgs = { inherit inputs; };
  }
