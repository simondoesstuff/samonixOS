{ inputs, ... }:
let
  utils = import ../hostUtils.nix { inherit inputs; };
in
utils.nixosSetup {
  system = "x86_64-linux";
  username = "mason";
  extraModules = [
    ./configuration.nix
    ./media/container.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-xps-15-7590-nvidia
  ];
  config = {
    personal.enable = true;
    entertainment.enable = true;
    language = {
      python.enable = true;
    };
  };
}
