{
  programs.nixvim.config.keymaps = [
    # INFO: Normal mode mappings
    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<cr>";
      options = {
        silent = true;
        desc = "save file";
      };
    }
    {
      mode = "n";
      key = "<leader>cd";
      action = "<cmd>cd %:h<cr>";
      options = {
        silent = true;
        desc = "change file dir";
      };
    }
    {
      mode = "n";
      key = "<leader>-";
      action = "<cmd>split<cr>";
      options = {
        silent = true;
        desc = "horizontal split";
      };
    }
    {
      mode = "n";
      key = "<leader>|";
      action = "<cmd>vsplit<cr>";
      options = {
        silent = true;
        desc = "vertical split";
      };
    }
    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>q<cr>";
      options = {
        silent = true;
        desc = "quit";
      };
    }
    {
      mode = "n";
      key = "<esc>";
      action = "<cmd>nohlsearch<cr><esc>";
      options = {
        silent = true;
        noremap = true;
        nowait = true;
        desc = "clear search highlight";
      };
    }
    # Swap gj & j and gk & k to allow for easier navigation in wrapped lines
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
      key = "gk";
      action = "k";
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "gj";
      action = "j";
      options = {
        silent = true;
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
      key = "<esc><esc>";
      # exit term mode -> go to norm mode
      action = "<C-\\><C-n>";
      options = {
        silent = true;
        noremap = true;
        nowait = true;
      };
    }
  ];
}
