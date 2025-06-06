{ pkgs, ... }:
{
  home.packages = [ pkgs.git-crypt ];

  programs.lazygit = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Simon Walker";
    userEmail = "simon@simonwalker.tech";
    extraConfig = {
      merge.tool = "nvimdiff2";
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
