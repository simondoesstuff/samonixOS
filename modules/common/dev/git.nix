{ pkgs, ... }:
{
  home.packages = [ pkgs.git-crypt ];

  programs.lazygit = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "masoniis";
    userEmail = "bott.m@comcast.net";
    extraConfig = {
      sendemail = {
        smtpserver = "smtp.gmail.com";
        smtpuser = "masonmbott@gmail.com";
        smtpencryption = "tls";
        smtpserverport = 587;
      };
      merge.tool = "nvimdiff2";
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
