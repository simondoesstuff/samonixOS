{inputs, ...}:
with inputs;
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    # specialArgs = {inherit nixos-wsl;};
    modules = [
      # include NixOS-WSL modules
      nixos-wsl.nixosModules.wsl
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        # nix.registry.nixpkgs.flake = nixpkgs;
        # home-manager.useGlobalPkgs = true;
        # home-manager.useUserPackages = true;
        home-manager.users.mason = {...}: {
          imports = [./temphome.nix ../../modules/linux/default.nix];
        };

        home-manager.extraSpecialArgs = {
          username = "mason";
          root = ../..;
        };

        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
    ];
  }
