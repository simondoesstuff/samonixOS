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
      	animation = { enabled = true, duration = 300 },
      })
    '';

    autoCmd = [
      {
        # Highlight on yank
        event = [ "TextYankPost" ];
        command = "lua require('undo-glow').yank()";
        group = "yankGrp";
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
        action.__raw = "require('undo-glow').paste_below";
        options = {
          noremap = true;
          desc = "Paste below with highlight";
        };
      }
      {
        mode = "n";
        key = "P";
        action.__raw = "require('undo-glow').paste_above";
        options = {
          noremap = true;
          desc = "Paste above with highlight";
        };
      }
    ];
  };
}
