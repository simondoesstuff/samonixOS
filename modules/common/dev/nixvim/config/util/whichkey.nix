{...}: {
  programs.nixvim = {
    plugins.which-key = {
      enable = true;
      settings = {
        preset = "modern";
        win = {
          no_overlap = true;
          border = "single";
          wo.winblend = 10;
          padding = [0 2];
          title = true;
          title_pos = "center";
        };
        spec = [
          {
            __unkeyed = "<leader>f";
            group = "file";
          }
          {
            __unkeyed = "<leader>l";
            group = "lsp";
          }
          {
            __unkeyed = "<leader>d";
            group = "debug";
          }
          {
            __unkeyed = "<leader>t";
            group = "terminal";
          }
        ];
      };
    };

    extraConfigLua =
      /*
      lua
      */
      ''
        vim.cmd("autocmd FileType rust lua WhichKeyRust()")
        function WhichKeyRust()
        	wk.register({
        		C = { name = "cargo" },
        	}, { prefix = "<leader>" })
           end
      '';
  };
}
