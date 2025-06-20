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
    ];
  };
}
