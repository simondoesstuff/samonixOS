{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.language.lua.enable {
    home.packages = with pkgs; [
      lua-language-server # lua language server
    ];
  };
}
