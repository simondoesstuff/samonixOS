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
      # clockify on linux? time tracker
      (timetrack { obsidianVaultPath = "/Users/mason/obsidian/obsidian"; }) # masonpkgs
    ];
  };
}
