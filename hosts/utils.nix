{inputs}: let
  inherit (inputs) nixpkgs nixos-wsl home-manager nixpkgs-unstable;
in {
  # General nixosSystem wrapper that takes in config system and username
  nixosSetup = {
    config,
    system,
    username,
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        nixos-wsl.nixosModules.wsl
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${username}" = {...}: {
            imports = [
              ./temphome.nix
              ../modules/linux/default.nix
              config
            ];
          };

          home-manager.extraSpecialArgs = {
            username = username;
            root = ./..;
            pkgs-unstable = import nixpkgs-unstable {inherit system;};
          };
        }
      ];
    };

  # General home-manager configuration wrapper that takes in config system and username
  homeManagerSetup = {
    config,
    system,
    username,
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [(import ../overlays/masonpkgs)];
      };
      extraSpecialArgs = {
        pkgs-unstable = import nixpkgs-unstable {inherit system;};
        username = username;
        root = ./..;
      };
      modules = [
        ./home.nix
        (
          if system == "aarch64-darwin" || system == "x86_64-darwin"
          then ../modules/darwin/default.nix
          else ../modules/linux/default.nix
        )
        config
      ];
    };
}
