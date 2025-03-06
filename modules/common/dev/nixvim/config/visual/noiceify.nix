{
  programs.nixvim = {
    plugins.notify.enable = true;
    plugins.noice.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>un";
        action = ''<cmd>lua require("noice").cmd("dismiss")<cr>'';
        options.desc = "dismiss notifications";
        options.noremap = true;
      }
    ];
  };
}
