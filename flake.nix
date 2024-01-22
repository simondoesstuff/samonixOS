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
      "mason@mac" = home-manager.lib.homeManagerConfiguration {
      	pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Darwin package source
        # inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
      homeConfigurations."mason@linux" = home-manager.lib.homeManagerConfiguration {
      	pkgs = nixpkgs.legacyPackages.x86_64linux; # linux package source

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
	};
}
