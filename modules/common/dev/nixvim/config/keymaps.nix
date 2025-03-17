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
    ];
  };
}
