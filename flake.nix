{
  description = "Home Manager configuration of mason";

  inputs = {
		# flake inputs are not automatically updated by Home Manager. Standard nix flake update command is needed.
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
			packages.x86_64-linux.homeConfiguratoins = {
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.aarch64-darwin; # darwin package source

					modules = [ ./home.nix ];
				};
			};

			packages.aarch64-darwin.homeConfigurations = {
				# defualt (cross-platform items) through home-manager switch
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.aarch64-darwin; # darwin package source

					modules = [ ./home/default.nix ];
				};
    };
	};
}
