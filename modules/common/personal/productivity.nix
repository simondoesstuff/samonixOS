# packages and config for productive activities
{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf config.personal.enable {
    home.packages = with pkgs; [
      obsidian
      zotero
      anki-bin
      (timetrack { obsidianVaultPath = "/Users/mason/obsidian/obsidian"; }) # masonpkgs
    ];
  };
}
