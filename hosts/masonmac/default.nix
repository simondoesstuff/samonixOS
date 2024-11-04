{inputs, ...}: let
  utils = import ../hostUtils.nix {inherit inputs;};
in
  utils.homeManagerSetup {
    system = "aarch64-darwin";
    username = "mason";
    config = {
      entertainment.enable = true;
      personal.enable = true;
      language = {
        web.enable = true;
        python.enable = true;
      };
    };
  }
