{
  programs.nixvim = {
    colorschemes.catppuccin.enable = true;

    # dependencies
    plugins.mini = {
      enable = true;
      modules.icons.enable = true;
      mockDevIcons = true;
    };

    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "bg", bg = "bg" })
      vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "bg" })
      vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "bg" })
    '';
  };
}
