{
  description = "Home Manager configuration of mason";

	inputs.home-manager.url = "github:nix-community/home-manager";
	inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { nixpkgs, home-manager, ... }:
		{
			packages.x86_64-linux.homeConfigurations = {
				mason = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.x86_64-linux;

					extraSpecialArgs = { 
						username = "mason";
					};						

					modules = [ ./home.nix ./hosts/linux/default.nix ];
			    };

				# Profile used for OS VM
				user = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.x86_64-linux;

					extraSpecialArgs = { 
						username = "user";
					};						

					modules = [ ./home.nix ./hosts/linux/os_class/default.nix  ];
				};
      };

			packages.aarch64-darwin.homeConfigurations = {
				mason = home-manager.lib.homeManagerConfiguration {
					pkgs = import nixpkgs { system = "aarch64-darwin"; };

					extraSpecialArgs = { 
						custompkgs = import ./custompkgs { 
							pkgs = import nixpkgs { system = "aarch64-darwin"; };
						};
						username = "mason";
					};						

					modules = [ ./home.nix ./hosts/darwin/default.nix ];
				};
			};
		};
}
