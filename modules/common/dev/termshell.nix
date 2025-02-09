{
  root,
  config,
  ...
}: {
  # INFO: Programs
  programs = {
    wezterm.enable = true; # terminal emulator
    starship.enable = true; # shell prompts
    # better cd command
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    # better ls command
    eza = {
      enable = true;
      enableZshIntegration = true;
      # enableAliases = true; # Default aliases
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
        # 2nd export: Add flutter to path, manually install because using nix on mac wouldn't work
        # 3rd export: Setting chrome executable for flutter to read from to launch web apps
        # export PATH=$PATH:$HOME/dev/sdk/flutter/bin:$PATH
        then ''
          export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
          export CHROME_EXECUTABLE="/Applications/Microsoft Edge Dev.app/Contents/MacOS/Microsoft Edge Dev"
        ''
        else "";
      # Added to (end) of .zshrc, init zoxide as per docs
      initExtra = "
			eval \"$(zoxide init zsh --cmd cd)\"
		";
      completionInit = "
			bindkey '^ ' autosuggest-accept
		";
    };
  };

  # home.packages = with pkgs; [ghostty]; broken on mac currently

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
}
