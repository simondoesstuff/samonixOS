# related to the visual editting experience!
{...}: {
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      settings = {
        scope = {
          show_end = false;
          show_start = false;
        };
      };
      todo-comments.enable = true;
    };
  };
}
