{
  root,
  config,
  ...
}: {
  # home.packages = with pkgs; [ghostty]; #broken on mac currently

  # INFO: Source dotfiles directly
  xdg.configFile = {
    wezterm = {
      source = root + /dotfiles/wezterm;
      recursive = true;
    };
    ghostty = {
      source = root + /dotfiles/ghostty;
      recursive = true;
    };
  };

  home.shellAliases = {
    cat = "bat";
  };

  # INFO: Programs
  programs = {
    wezterm.enable = true; # terminal emulator
    starship.enable = true; # shell prompts
    # better cd command
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
    bat.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    # shell
    zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      # Added to (end) of .zprofile
      profileExtra =
        if config.isDarwin
        # 1st export: Add docker to path, docker desktop isn't on nix I think?
        # 2nd export: Setting chrome executable for flutter to read from to launch web apps
        then ''
          export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
          export CHROME_EXECUTABLE="/Applications/Microsoft Edge Dev.app/Contents/MacOS/Microsoft Edge Dev"
        ''
        else "";
      completionInit = "
				bindkey '^ ' autosuggest-accept
			";
    };
  };
}
