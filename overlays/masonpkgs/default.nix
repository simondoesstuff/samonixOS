# overlays/default.nix
self: super:
let
  lib = super.lib;

  # Read plugin files from relative dir
  pluginsPath = ./nvim-plugins;
  pluginFiles = lib.attrNames (
    lib.filterAttrs (name: type: type == "regular" && lib.strings.hasSuffix ".nix" name) (
      builtins.readDir pluginsPath
    )
  );

  # Create a custom plugins attr set
  customVimPlugins = lib.listToAttrs (
    lib.map (file: {
      # The key for the attr set, e.g., "slimline.nix" -> "slimline-masonpkgs"
      name = "${lib.strings.removeSuffix ".nix" file}-masonpkgs";
      # The value for the attr set, e.g., callPackage ./nvim-plugins/slimline.nix {}
      value = super.callPackage (pluginsPath + "/${file}") { };
    }) pluginFiles
  );

in
{
  lobster = args: super.callPackage ./lobster/default.nix args;
  jerry = args: super.callPackage ./jerry/default.nix args;
  timetrack = args: super.callPackage ./timetrack/default.nix args;

  vimPlugins = super.vimPlugins // customVimPlugins;
}
