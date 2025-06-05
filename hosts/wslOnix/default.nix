{ inputs, ... }:
let
  inherit (inputs) nixos-wsl;
  utils = import ../hostUtils.nix { inherit inputs; };
in
utils.nixosSetup {
  system = "x86_64-linux";
  username = "simon";
  extraModules = [
    nixos-wsl.nixosModules.wsl # nixos-wsl necessary modules
    ./configuration.nix
  ];
  hmExtra.home.homeDirectory = "/home/mason";
  config = {
    personal.enable = true;
    language = {
      python.enable = true;
    };
  };
}
