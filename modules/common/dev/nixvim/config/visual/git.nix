{...}: {
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings.current_line_blame_opts.delay = 0;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>gb";
        action = "<cmd>Gitsigns toggle_current_line_blame<cr>";
        options.desc = "toggle blame";
      }
    ];
  };
}
