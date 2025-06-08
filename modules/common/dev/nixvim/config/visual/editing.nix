# related to the visual editing experience!
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      illuminate.enable = true;
      todo-comments.enable = true;
      # TODO: Fix
      # intellitab = {
      #   enable = true;
      #   # TODO: remove custom intellitab package once upstream accepts pr
      #   package = pkgs.vimUtils.buildVimPlugin {
      #     name = "intellitab";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "simondoesstuff";
      #       repo = "intellitab.nvim";
      #       rev = "fad06f80b44186767eba348283c3b88827a969b1";
      #       sha256 = "sha256-ShMECcqFQS607ZWRKHEh1cSLT/XChx5JpNOHSP3h/7I=";
      #     };
      #   };
      # };
      nvim-ufo.enable = true;
    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "undo-glow";
        src = pkgs.fetchFromGitHub {
          owner = "y3owk1n";
          repo = "undo-glow.nvim";
          rev = "d2a489fd0549c1a8e39f04c460621d4535fdc033"; # 6/6/25
          sha256 = "sha256-+WyALFOR55uwr4hDINz59M+B41T2WnRCD1kDVD2h6UA=";
        };
      })
    ];

    extraConfigLua = ''
      require("undo-glow").setup({
      	animation = { 
      		enabled = true, 
      		duration = 300, 
      		animtion_type = "zoom",
      		window_scoped = true,
      	},
      })
    '';

    autoCmd = [
      {
        # Highlight on yank
        event = [ "TextYankPost" ];
        command = "lua require('undo-glow').yank()";
      }
      {
        event = [ "CmdLineLeave" ];
        pattern = [
          "/"
          "?"
        ];
        desc = "Highlight when search cmdline leave";
        callback.__raw = ''
          function()
            require("undo-glow").search_cmd({
              animation = {
                animation_type = "fade",
              },
            })
          end
        '';
      }
    ];

    keymaps = [
      {
        mode = "n";
        key = "zR";
        action.__raw = "function() require('ufo').openAllFolds() end";
        options = {
          silent = true;
          desc = "open all folds";
        };
      }
      {
        mode = "n";
        key = "zM";
        action.__raw = "function() require('ufo').closeAllFolds() end";
        options = {
          silent = true;
          desc = "close all folds";
        };
      }
      {
        mode = "n";
        key = "p";
        action.__raw = "function() require('undo-glow').paste_below() end";
        options = {
          noremap = true;
          desc = "Paste below with highlight";
        };
      }
      {
        mode = "n";
        key = "P";
        action.__raw = "function() require('undo-glow').paste_above() end";
        options = {
          noremap = true;
          desc = "Paste above with highlight";
        };
      }
      {
        mode = "n";
        key = "u";
        action.__raw = "function() require('undo-glow').undo() end";
        options = {
          noremap = true;
          desc = "Undo with highlight";
        };
      }
      {
        mode = "n";
        key = "<C-r>";
        action.__raw = "function() require('undo-glow').redo() end";
        options = {
          noremap = true;
          desc = "Redo with highlight";
        };
      }
      {
        mode = "n";
        key = "n";
        action.__raw = ''
          function() 
          	require('undo-glow').search_next({
          		animation = {
          			animation_type = "strobe",
          		},
            })
          end'';
        options = {
          noremap = true;
          desc = "Search next with highlight";
        };
      }
      {
        mode = "n";
        key = "N";
        action.__raw = ''
          function() 
          	require('undo-glow').search_prev({
          		animation = {
          			animation_type = "strobe",
          		},
            })
          end'';
        options = {
          noremap = true;
          desc = "Search previous with highlight";
        };
      }
      {
        mode = "n";
        key = "*";
        action.__raw = ''
          function() 
          	require('undo-glow').search_star({
          		animation = {
          			animation_type = "strobe",
          		},
            })
          end'';
        options = {
          noremap = true;
          desc = "Search * with highlight";
        };
      }
      {
        mode = "n";
        key = "#";
        action.__raw = ''
          function() 
          	require('undo-glow').search_hash({
          		animation = {
          			animation_type = "strobe",
          		},
            })
          end'';
        options = {
          noremap = true;
          desc = "Search # with highlight";
        };
      }
      # TODO: didn't work idk why
      # {
      #   mode = [
      #     "n"
      #     "x"
      #   ];
      #   key = "gc";
      #   action.__raw = "function() require('undo-glow').comment() end";
      #   options = {
      #     expr = true;
      #     noremap = true;
      #     desc = "Toggle comment with highlight";
      #   };
      # }
      # {
      #   mode = "o";
      #   key = "gc";
      #   action.__raw = "function() require('undo-glow').comment_text_object() end";
      #   options = {
      #     noremap = true;
      #     desc = "Comment textobject with highlight";
      #   };
      # }
      # {
      #   mode = "n";
      #   key = "gcc";
      #   action.__raw = "function() require('undo-glow').comment_line() end";
      #   options = {
      #     expr = true;
      #     noremap = true;
      #     desc = "Toggle comment line with highlight";
      #   };
      # }
    ];
  };
}
