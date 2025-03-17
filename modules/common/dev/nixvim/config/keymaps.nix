{
  programs.nixvim.config.keymaps = [
    # INFO: Normal mode mappings
    {
      mode = "n";
      key = "j";
      action = "gj";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "k";
      action = "gk";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>cd %:h<cr>";
      options = {
        silent = true;
        desc = "Change file dir";
      };
    }

    # INFO: Visual mode mappings
    {
      mode = "v";
      key = "p";
      action = "\"_dP";
      options = {
        silent = true;
      };
    }

    # INFO: Terminal mode mappings
    {
      mode = "t";
      key = "<esc>";
      action = "<esc>";
      options = {
        silent = true;
        noremap = true;
      };
    }
    {
      mode = "t";
      key = "<esc><esc>";
      # exit term mode -> go to norm mode
      action = "<C-\\><C-n>";
      options = {
        silent = true;
        noremap = true;
      };
    }
  ];
}
