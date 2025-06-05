{ inputs, ... }:
let
  utils = import ../hostUtils.nix { inherit inputs; };
in
utils.homeManagerSetup {
  system = "aarch64-darwin";
  username = "mason";
  hmExtra.home.homeDirectory = "/Users/mason";
  config = {
    entertainment.enable = true;
    personal.enable = true;
    language = {
      python.enable = true;
    };
  };
}
