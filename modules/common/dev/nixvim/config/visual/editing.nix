# related to the visual editing experience!
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # usage highlighting & goto usages
      illuminate.enable = true;
      todo-comments.enable = true;
      intellitab.enable = true;
      nvim-ufo.enable = true;
      nvim-ufo.settings.provider-selector =
        #lua
        ''
          provider_selector = function(bufnr, filetype, buftype)
          	return {'treesitter', 'indent'}
          end
        '';
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
      # integration details for intellitab.
      #   does not interfere with blink-cmp by stealing <Tab> because blink-cmp
      #   is just that cracked
      {
        mode = "i";
        key = "<Tab>";
        action.__raw = # lua
          ''
            function()
              require("intellitab").indent()
            end
          '';
      }
      # vim illuminate: goto usages
      {
        mode = "n";
        key = "]]";
        action.__raw = "function() require('illuminate').goto_next_reference(false) end";
        options = {
          silent = true;
          desc = "goto next reference";
        };
      }
      {
        mode = "n";
        key = "[[";
        action.__raw = "function() require('illuminate').goto_prev_reference(false) end";
        options = {
          silent = true;
          desc = "goto previous reference";
        };
      }
      # folds
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
