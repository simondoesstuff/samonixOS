{
  programs.nixvim = {
    plugins = {
      neo-tree = {
        enable = true;
        extraOptions = {
          filesystem = {
            bind_to_cwd = true; # true creates a 2-way binding between vim's cwd and neo-tree's root
            cwd_target = {
              sidebar = "tab"; # sidebar is when position = left or right
              current = "window"; # current is when position = current
            };
          };
        };
      };
      yazi.enable = true;
    };

    keymaps = [
      {
        action = "<cmd>Neotree toggle source=filesystem reveal=true position=left<cr>";
        key = "<leader>e";
        # desc = "testtest";
        options = {
          silent = true;
        };
      }
    ];
  };

  # {
  # 	keys = {
  # 		{
  # 			"<leader>e",
  # 			"<cmd>Neotree toggle source=filesystem reveal=true position=left<cr>",
  # 			desc = "neotree explorer"
  # 		},
  # 	},
  # },
  # {
  # 	"mikavilpas/yazi.nvim",
  # 	event = "VeryLazy",
  # 	keys = {
  # 		{
  # 			"<leader>E",
  # 			"<cmd>Yazi<cr>",
  # 			desc = "Open yazi at the current file",
  # 		},
  # 		{
  # 			"<leader>cw",
  # 			"<cmd>Yazi cwd<cr>",
  # 			desc = "Open the file manager in nvim's working directory",
  # 		},
  # 	},
  # 	opts = {
  # 		open_for_directories = true, -- replace netrw (neovim explorer)
  # 	},
  # }
}
