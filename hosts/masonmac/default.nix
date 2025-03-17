{inputs, ...}: let
  utils = import ../hostUtils.nix {inherit inputs;};
in
  utils.homeManagerSetup {
    system = "aarch64-darwin";
    username = "simon";
    config = {
      entertainment.enable = true;
      personal.enable = true;
      language = {
        python.enable = true;
      };
    };
  }
