{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
    plugins.which-key.enable = true;
    plugins.telescope.enable = true;
    plugins.neoscroll.enable = true;

    # dependencies
    plugins.mini = {
      enable = true;
      modules.icons.enable = true;
      mockDevIcons = true;
    };
  };
}
