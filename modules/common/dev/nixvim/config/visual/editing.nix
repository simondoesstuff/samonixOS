# related to the visual editing experience!
{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      # usage highlighting & goto usages
      illuminate.enable = true;
      todo-comments.enable = true;
      intellitab = {
        enable = true;
        # TODO: remove custom intellitab package once upstream accepts pr
        package = pkgs.vimUtils.buildVimPlugin {
          name = "intellitab";
          src = pkgs.fetchFromGitHub {
            owner = "simondoesstuff";
            repo = "intellitab.nvim";
            rev = "fad06f80b44186767eba348283c3b88827a969b1";
            sha256 = "sha256-ShMECcqFQS607ZWRKHEh1cSLT/XChx5JpNOHSP3h/7I=";
          };
        };
      };
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
