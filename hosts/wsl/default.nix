{inputs, ...}:
let
  inherit (inputs) nixpkgs nixos-wsl home-manager nixpkgs-unstable;
in
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    # specialArgs = {inherit nixos-wsl;};
    modules = [
      nixos-wsl.nixosModules.wsl # nixos-wsl modules
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.mason = {...}: {
          imports = [
						./temphome.nix 
						../../modules/linux/default.nix
						{
							personal.enable = false;
							test.enable = true;
						}
					];
        };

        home-manager.extraSpecialArgs = {
          username = "mason";
          root = ../..;
					pkgs-unstable = import nixpkgs-unstable {system = "x86_64-linux";};
        };
      }
    ];
  }
