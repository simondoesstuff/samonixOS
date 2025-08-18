{ ... }:
{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;

      config = {
        warn_timeout = "-1m"; # disable warning that it is taking long, common for any flake and gets annoying
        hide_env_diff = true; # hides the massive env export string that gets printed on entrance if off silent mode
      };
    };
  };

  home.shellAliases = {
    dr = "direnv reload";
    da = "direnv allow";
  };
}
