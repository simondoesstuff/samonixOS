{lib, ...}: let
  pluginsDir = ./plugins;
  allFiles = lib.filesystem.listFilesRecursive pluginsDir;
  imports = builtins.filter (path: lib.hasSuffix ".nix" (toString path)) allFiles;

  extraConfigLua = builtins.concatStringsSep "\n" (map builtins.readFile [
    ./config/autocmds.lua
    ./config/keymaps.lua
    ./config/options.lua
  ]);
in {
  programs.nixvim = {
    enable = true;
    inherit extraConfigLua;
  };

  inherit imports;
}
