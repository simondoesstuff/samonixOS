{
  # Zoxide is a better form of 'cd' (chang dir)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Shell prompt
  programs.starship = {
    enable = true;
  };

  # Better ls
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    # enableAliases = true; # Default aliases
  };
}
