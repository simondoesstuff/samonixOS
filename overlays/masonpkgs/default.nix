# overlays/default.nix
self: super:
let
  lib = super.lib;

  # INFO: -------------------------------
  #         custom nvim plugins
  # -------------------------------------

  # Read plugin files from relative dir
  nvimPluginsPath = ./nvim-plugins;
  nvimPluginFiles = lib.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.strings.hasSuffix ".nix" name) (
      builtins.readDir nvimPluginsPath
    )
  );

  # Create a custom plugins attr set
  customVimPlugins = lib.listToAttrs (
    lib.map (file: {
      # The key for the attr set, e.g., "slimline.nix" -> "slimline-masonpkgs"
      name = "${lib.strings.removeSuffix ".nix" file}-masonpkgs";
      # The value for the attr set, e.g., callPackage ./nvim-plugins/slimline.nix {}
      value = super.callPackage (nvimPluginsPath + "/${file}") { };
    }) nvimPluginFiles
  );

  # INFO: --------------------------------
  #         custom node packages
  # --------------------------------------

  nodePackagesPath = ./node-packages;
  nodePackagesFiles = lib.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.strings.hasSuffix ".nix" name) (
      builtins.readDir nodePackagesPath
    )
  );

  customNodePackages = lib.listToAttrs (
    lib.map (file: {
      name = "${lib.strings.removeSuffix ".nix" file}-masonpkgs";
      value = super.callPackage "${nodePackagesPath}/${file}" { };
    }) nodePackagesFiles
  );

in
{
  lobster = args: super.callPackage ./lobster/default.nix args;
  jerry = args: super.callPackage ./jerry/default.nix args;
  timetrack = args: super.callPackage ./timetrack/default.nix args;

  vimPlugins = super.vimPlugins // customVimPlugins;
  nodePackages = super.nodePackages // customNodePackages;
}
