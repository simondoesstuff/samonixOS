{inputs, ...}: let
  inherit (inputs) nixpkgs home-manager nixpkgs-unstable;
in
  home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs {
      system = "aarch64-darwin";
      overlays = [(import ../../overlays/masonpkgs)];
    };

    extraSpecialArgs = {
      pkgs-unstable = import nixpkgs-unstable {system = "aarch64-darwin";};
      username = "mason";
      root = ../..; # root of flake
    };

    modules = [
      ./home.nix
      ./config.nix
      ../../modules/darwin/default.nix
    ];
  }
