{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;
    plugins.todo-comments.enable = true;

    # dependencies
    plugins.mini = {
      enable = true;
      modules.icons.enable = true;
      mockDevIcons = true;
    };

    plugins.colorizer = {
      enable = true;
      settings.user_default_options = {
        tailwind = "both"; # lsp + normal
        AARRGGBB = true;
        RRGGBBAA = true;
        names = false; # dont highlight "blue"
        css = true;
      };
    };

    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg", bg = "bg" })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "bg" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "bg" })
    '';
  };
}
