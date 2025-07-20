# packages and config for productive activities
{
  lib,
  pkgs,
  config,
  pkgs-unstable,
  ...
}:
{
  config = lib.mkIf config.personal.enable {
    home.packages = [
      pkgs-unstable.obsidian # might as well pin to unstable since it is proprietary and will never need to build anyway, amirite?
      pkgs.zotero
      pkgs.anki-bin
      # clockify on linux? time tracker
      (pkgs.timetrack { obsidianVaultPath = "/Users/mason/obsidian/obsidian"; }) # masonpkgs
    ];
  };
}
