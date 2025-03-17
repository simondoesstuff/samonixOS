{pkgs, ...}: {
  home.packages = [pkgs.git-crypt];

  programs.lazygit = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Simon Walker";
    userEmail = "simon@simonwalker.tech";
    extraConfig = {
      # relevant for ssh auth
      url."git@github.com:".insteadOf = "https://github.com/";
      # TODO: configure email settings
      #
      # sendemail = {
      #   smtpserver = "smtp.gmail.com";
      #   smtpuser = "masonmbott@gmail.com";
      #   smtpencryption = "tls";
      #   smtpserverport = 587;
      # };
      merge.tool = "nvimdiff2";
      pull.rebase = false;
      init.defaultBranch = "main";
    };
  };

  gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
