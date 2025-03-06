# "bars" for the tab and status line
{
  programs.nixvim = {
    plugins.lualine.enable = true;
    plugins.barbar.enable = true;
  };
}
