{ pkgs, ... }:
{
  # allow unfree stuff
  nixpkgs.config.allowUnfree = true;

  # enable signing for just this device
  programs.git = {
    signing = {
      key = "~/.ssh/github.pub";
      signByDefault = true;
      format = "ssh";
    };
  };

  home.packages = with pkgs; [
    slack
  ];

  programs.zsh.profileExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"

    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba shell init' !!
    export MAMBA_EXE='/opt/homebrew/opt/micromamba/bin/mamba';
    export MAMBA_ROOT_PREFIX='/Users/simon/mamba';
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
    		eval "$__mamba_setup"
    else
    		alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<
  '';
}
