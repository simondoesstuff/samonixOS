{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "actions-preview";
        src = pkgs.fetchFromGitHub {
          owner = "aznhe21";
          repo = "actions-preview.nvim";
          rev = "4ab7842eb6a5b6d2b004f8234dcf33382a0fdde2";
          sha256 = "MP1hohDL2JFembwW+cb2S+v2Y7j0iZw1jPPKTZiNCWI=";
        };
      })
    ];

    extraConfigLua = ''
         require("actions-preview").setup({
            telescope = require("telescope.themes").get_dropdown {
            	sorting_strategy = "ascending",
            	layout_strategy = "vertical",
            	winblend = 10,
            	layout_config = {
            		-- anchor = "CENTER",  -- vertically and horizontally
            		width = 0.8,
            		height = 0.9,
            		prompt_position = "top",
            		preview_cutoff = 25,
            		preview_height = function(_, _, max_lines)
            			return max_lines - 25
            		end,
            	},
            },
      })
    '';
  };
}
