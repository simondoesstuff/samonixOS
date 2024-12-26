{
  root,
  config,
  ...
}: {
  # INFO: Terminal stuff
  programs.wezterm.enable = true;

  # Source wezterm dotfile directly
  xdg.configFile.wezterm = {
    source = root + /dotfiles/wezterm;
    recursive = true;
  };
  xdg.configFile.ghostty = {
    source = root + /dotfiles/ghostty;
    recursive = true;
  };

  # INFO: Shell stuff
  programs.zsh = {
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
      then ''
        export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
        export PATH=$PATH:$HOME/dev/sdk/flutter/bin:$PATH
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

  # Shell prompt
  programs.starship = {
    enable = true;
  };

  # Zoxide is a better form of 'cd' (chang dir)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Better ls
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    # enableAliases = true; # Default aliases
  };
}
