# "bars": tabs, status line, commands
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins.barbar = {
      enable = true;
      settings = {
        icons = {
          button = false;
          separator_at_end = false;
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
    plugins.barbecue = {
      enable = true;
      settings.show_dirname = false;
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

      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.nvim-web-devicons
      # TODO: Fix build error that came with updating to 25.05
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "battery";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "justinhj";
      #     repo = "battery.nvim";
      #     # 3/30/2025
      #     rev = "1dd2a2bd6958166d3b9ace93cff76251ad4c09b8";
      #     sha256 = "sha256-GSVrbS15qm1FmCt1qwv5ETCWRM/jc3CtEw7F5UrzbAY=";
      #   };
      # })
    ];

    extraConfigLua = builtins.readFile ./editing.lua;

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<cmd>BufferClose!<cr>";
        options.desc = "close buffer";
      }
      {
        mode = "n";
        key = "<C-,>";
        action = "<cmd>BufferPrevious<cr>";
        options.desc = "previous buffer";
      }
      {
        mode = "n";
        key = "<C-.>";
        action = "<cmd>BufferNext<cr>";
        options.desc = "next buffer";
      }
      {
        mode = "n";
        key = "<C-S-.>";
        action = "<cmd>BufferMoveNext<cr>";
        options.desc = "move buffer to next";
      }
      {
        mode = "n";
        key = "<C-S-,>";
        action = "<cmd>BufferMovePrevious<cr>";
        options.desc = "move buffer to previous";
      }
    ];
  };
}
