{
  root,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # ghostty  #broken on mac currently
    fswatch
    watch
    parallel
    ripgrep
    # TODO: better place for this?
    mitmproxy
  ];

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
      initExtra = ''
        set -o vi
      '';
      completionInit = "
				bindkey '^[l' autosuggest-accept
			";
    };
  };
}
