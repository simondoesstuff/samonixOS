{ inputs }:
let
  inherit (inputs) nixpkgs home-manager;
in
{
  # General nixosSystem wrapper that takes in config system and username
  nixosSetup =
    {
      config,
      system,
      username,
      extraModules ? [ ],
    }:
    # TODO: Look into using this pkgs instead of nixpkgs.lib.nixosSystem:
    # pkgs = import nixpkgs{overlays=[flakeB.overlay];inherit system;};
    # and then use pkgs.nixos instead of nixpkgs.lib.nixosSystem
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      modules = [
        home-manager.nixosModules.home-manager
        {
          # home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${username} =
            { ... }:
            {
              nixpkgs.overlays = [ (import ../overlays/masonpkgs) ];
              imports = [
                ../modules/linux/default.nix
                config
                inputs.nixvim.homeManagerModules.nixvim
                inputs.spicetify.homeManagerModules.spicetify
              ];
            };

          home-manager.extraSpecialArgs = {
            pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
            pkgs-spice = inputs.spicetify.legacyPackages.${system};
            username = username;
            root = ./..;
          };
        }
      ] ++ extraModules;
    };

  # General home-manager configuration wrapper that takes in config system and username
  homeManagerSetup =
    {
      config,
      system,
      username,
    }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import ../overlays/masonpkgs) ];
      };
      extraSpecialArgs = {
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
        pkgs-spice = inputs.spicetify.legacyPackages.${system};
        username = username;
        root = ./..;
      };
      modules = [
        (
          if system == "aarch64-darwin" || system == "x86_64-darwin" then
            ../modules/darwin/default.nix
          else
            ../modules/linux/default.nix
        )
        inputs.nixvim.homeManagerModules.nixvim
        inputs.spicetify.homeManagerModules.spicetify
        config
        { homeManagerIsolated = true; }
      ];
    };
}
