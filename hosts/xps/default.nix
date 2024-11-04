{inputs, ...}: let
  utils = import ../hostUtils.nix {inherit inputs;};
in
  utils.nixosSetup {
    system = "x86_64-linux";
    username = "mason";
    extraModules = [
      ./configuration.nix
      ./hardware-configuration.nix
    ];
    config = {
      personal.enable = true;
      language = {
        python.enable = true;
      };
    };
  }
