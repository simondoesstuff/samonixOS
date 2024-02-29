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
		lobster.url = "github:justchokingaround/lobster"; # add this line
  };

  outputs = { nixpkgs, home-manager, lobster, ... }:
    {
			packages.x86_64-linux.homeConfigurations = {
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.x86_64-linux; # linux package source

					extraSpecialArgs = { inherit lobster; }; # pass lobster as a special argument
					modules = [ ./home/default.nix ./linux/default.nix ];
				};
			};

			packages.aarch64-darwin.homeConfigurations = {
				# defualt (cross-platform items) through home-manager switch
				"mason" = home-manager.lib.homeManagerConfiguration {
					pkgs = nixpkgs.legacyPackages.aarch64-darwin; # darwin package source

					extraSpecialArgs = { inherit lobster; }; # pass lobster as a special argument
					modules = [ ./home/default.nix ./darwin/default.nix ]; # pass inputs as an argument
				};
    };
	};
}
