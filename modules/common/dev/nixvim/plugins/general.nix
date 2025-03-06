{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;
    plugins.neoscroll.enable = true;
    plugins.lualine.enable = true;

    # dependencies
    plugins.mini = {
      enable = true;
      modules.icons.enable = true;
      mockDevIcons = true;
    };
  };
}
