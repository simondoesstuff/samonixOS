{
  description = "Home Manager configuration of mason";

	inputs.home-manager.url = "github:nix-community/home-manager";
	inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

	inputs.jerry.url = "github:justchokingaround/jerry";

  outputs = { nixpkgs, home-manager, jerry, ... }:
    {
			packages.x86_64-linux.homeConfigurations = {
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.x86_64-linux;

					# extraSpecialArgs = { inherit lobster; }; # pass lobster as a special argument
					modules = [ ./hosts/shared/default.nix ./hosts/linux/default.nix ];
				};
			};

			packages.aarch64-darwin.homeConfigurations = {
				# defualt (cross-platform items) through home-manager switch
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs { system = "aarch64-darwin"; };

					extraSpecialArgs = { inherit jerry; }; # pass lobster/jerry as a special args 
				  modules = [ ./home.nix ./hosts/shared/default.nix ./hosts/darwin/default.nix ];
				};
    };
	};
}
