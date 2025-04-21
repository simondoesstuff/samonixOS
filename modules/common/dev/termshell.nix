{
  config,
  root,
  pkgs,
  ...
}:
{
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
    wezterm.enable = false; # terminal emulator
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
      completionInit = "
				bindkey '^ ' autosuggest-accept
				bindkey '^l' autosuggest-accept
			";
      initExtra = ''
        set -o vi

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/Users/simon/app/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/Users/simon/app/miniforge3/etc/profile.d/conda.sh" ]; then
                . "/Users/simon/app/miniforge3/etc/profile.d/conda.sh"
            else
                export PATH="/Users/simon/app/miniforge3/bin:$PATH"
            fi
        fi
        unset __conda_setup

        if [ -f "/Users/simon/app/miniforge3/etc/profile.d/mamba.sh" ]; then
            . "/Users/simon/app/miniforge3/etc/profile.d/mamba.sh"
        fi
        # <<< conda initialize <<<

      '';
    };
  };
}
