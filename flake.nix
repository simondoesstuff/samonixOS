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
			homeConfigurations = {
			# Available through 'home-manager switch --flake #mason@mac'
      "mason@mac" = home-manager.lib.homeManagerConfiguration {
      	pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Darwin package source

        modules = [ ./home.nix ];
      };

			# Available through 'home-manager switch --flake #mason@linux'
      "mason@linux" = home-manager.lib.homeManagerConfiguration {
      	pkgs = nixpkgs.legacyPackages.x86_64linux; # linux package source

        modules = [ ./home.nix ];
      };
    };
	};
}
