# overlays/default.nix
self: super:
let
  lib = super.lib;

  # INFO: --------------------------------------------------------------
  #         Auto read nvim-plugins dir to an attr set for overlay
  # --------------------------------------------------------------------

  pluginsPath = ./nvim-plugins;
  pluginFiles = lib.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.strings.hasSuffix ".nix" name) (
      builtins.readDir pluginsPath
    )
  );

  customVimPlugins = lib.listToAttrs (
    lib.map (file: {
      # plugin name for the vim plugin overlay is based on file name + masonpkgs
      # "slimline.nix" -> "slimline-masonpkgs"
      name = "${lib.strings.removeSuffix ".nix" file}-masonpkgs";
      # The value for the attr set, e.g., callPackage ./nvim-plugins/slimline.nix {}
      value = super.callPackage (pluginsPath + "/${file}") { };
    }) pluginFiles
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
  jerry = args: super.callPackage ./jerry/default.nix args;
  lobster = args: super.callPackage ./lobster/default.nix args;
  timetrack = args: super.callPackage ./timetrack/default.nix args;

  vimPlugins = super.vimPlugins // customVimPlugins;
  nodePackages = super.nodePackages // customNodePackages;
}
