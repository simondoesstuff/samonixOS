{ inputs, ... }:
let
  utils = import ../hostUtils.nix { inherit inputs; };
in
utils.homeManagerSetup {
  system = "x86_64-linux";
  username = "simon";
  config = {
    entertainment.enable = false;
    personal.enable = false;
    language = {
      python.enable = false;
    };
  };
}
