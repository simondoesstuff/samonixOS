{
  programs.nixvim.config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      # Normal mode mappings
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
        key = "<leader>fn";
        action = "<cmd>enew<cr>";
        options = {
          silent = true;
          desc = "New file";
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

      # Visual mode mappings
      {
        mode = "v";
        key = "p";
        action = "\"_dP";
        options = {
          silent = true;
        };
      }

      # Terminal mode mappings
      {
        mode = "t";
        key = "<esc>";
        action = "<C-\\><C-n>";
        options = {
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-h>";
        action = "<Cmd>wincmd h<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-j>";
        action = "<Cmd>wincmd j<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-k>";
        action = "<Cmd>wincmd k<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-l>";
        action = "<Cmd>wincmd l<CR>";
        options = {
          silent = true;
        };
      }
      {
        mode = "t";
        key = "<C-w>";
        action = "<C-\\><C-n><C-w>";
        options = {
          silent = true;
        };
      }
    ];
  };
}
