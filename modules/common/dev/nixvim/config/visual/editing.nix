# related to the visual editting experience!
{pkgs, ...}: {
  programs.nixvim = {
    plugins = {
      indent-blankline = {
        enable = true;
        settings = {
          scope = {
            show_end = false;
            show_start = false;
          };
        };
      };
      illuminate.enable = true;
      todo-comments.enable = true;
      intellitab = {
        enable = true;
        # TODO: remove custom intellitab package once upstream accepts pr
        package = pkgs.vimUtils.buildVimPlugin {
          name = "intellitab";
          src = pkgs.fetchFromGitHub {
            owner = "simondoesstuff";
            repo = "intellitab.nvim";
            rev = "fad06f80b44186767eba348283c3b88827a969b1";
            sha256 = "sha256-ShMECcqFQS607ZWRKHEh1cSLT/XChx5JpNOHSP3h/7I=";
          };
        };
      };
    };
  };
}
