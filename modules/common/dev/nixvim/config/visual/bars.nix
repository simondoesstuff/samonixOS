# "bars": tabs, status line, commands
{pkgs, ...}: {
  programs.nixvim = {
    plugins.barbar = {
      enable = true;
      settings = {
        icons = {
          button = false;
          separator_at_end = false;
          separator = {
            left = "┃";
            right = "";
          };
          inactive.separator = {
            left = "┃";
            right = "";
          };
        };

        sidebar_filetypes = {
          "neo-tree" = {
            event = "BufWipeout";
            text = "file tree";
          };
        };

        auto_hide = 1; # Hide if 1 or less buffers
      };
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "slimline";
        src = pkgs.fetchFromGitHub {
          owner = "sschleemilch";
          repo = "slimline.nvim";
          rev = "5a7e91619496c4655e02e7ba26aae6b9a5b5a564";
          sha256 = "cFQmD/icMBdwdUUCAvZM1Z3pSFdxQCuk8I435qYvhHY=";
        };
      })
    ];

    extraConfigLua = ''
          vim.g.barbar_auto_setup = false
        require('slimline').setup ({
      		style = 'fg';
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>BufferClose!<cr>";
        options.desc = "close buffer";
      }
      {
        mode = "n";
        key = ",";
        action = "<cmd>BufferPrevious<cr>";
        options.desc = "previous buffer";
      }
      {
        mode = "n";
        key = ".";
        action = "<cmd>BufferNext<cr>";
        options.desc = "next buffer";
      }
    ];
  };
}
