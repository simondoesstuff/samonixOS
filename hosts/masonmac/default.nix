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

    # TODO: In the future, I can consider including every module and just have them
    # be conditionally configiured and included based on system rather than specifically
    # importing the darwin folder or linux for other hosts
    modules = [
      ./home.nix
      ../../modules/darwin/default.nix
      {
        # INFO: Set of implicit configuration attributes that determine
        # what modules are included and other package settings and options
        entertainment.enable = true;
        personal.enable = true;
      }
    ];
  }
