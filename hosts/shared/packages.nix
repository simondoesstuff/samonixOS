{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # Required for obsidian
  ];

  home.packages = with pkgs; (
    # General packages for system-wide use
    [
      fira-code-nerdfont # decent nerd font
      neofetch # Show os info and such

      # Used in neovim telescope, as well as just generally useful
      ripgrep # Fast grep
      fd # Advanced find
    ]
    # Personal systen packages
    ++ [
      obsidian # MD note taker editor
      #INFO: On mac, since this modifies signed discord, it now has to be allowed in security settings.
      (discord.override {
        withOpenASAR = true;
        # withVencord = true;
      })
    ]
  );
}
