{
  config,
  root,
  pkgs,
  ...
}:
{
  # ghostty only available on linux in nixpkgs at the moment
  home.packages = if config.isLinux then [ pkgs.ghostty ] else [ ];

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
    wezterm.enable = config.isDarwin; # terminal emulator
    starship.enable = true; # shell prompts
    # better cd command
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    # better cat command
    bat.enable = true;
    # better ls command
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
      initContent = ''
        set -o vi
      '';
      completionInit = "
				bindkey '^ ' autosuggest-accept
				bindkey '^l' autosuggest-accept
			";
    };
  };
}
