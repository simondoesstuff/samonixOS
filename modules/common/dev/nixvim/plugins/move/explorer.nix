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
        mode = "n";
        key = "<leader>e";
        options.desc = "explorer (neotree)";
      }
      {
        action = "<cmd>Yazi<cr>";
        key = "<leader>E";
        options.desc = "explorer (yazi)";
      }
      {
        action = "<cmd>Yazi cwd<cr>";
        key = "<leader>cw";
        options.desc = "yazi in cwd";
        # options.open_for_directories = true; doesn't exist on nixvim?
      }
    ];
  };
}
