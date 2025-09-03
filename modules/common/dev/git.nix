{ pkgs, ... }:
{
  home.packages = [ pkgs.git-crypt ];

  programs.lazygit = {
    enable = true;
    settings = {
      notARepository = "skip";
    };
  };

  programs.git = {
    enable = true;
    userName = "Simon Walker";
    userEmail = "simon@simonwalker.tech";
    extraConfig = {
      merge.tool = "nvimdiff2";
      init.defaultBranch = "main";
      pull.rebase = false; # default to merging
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
