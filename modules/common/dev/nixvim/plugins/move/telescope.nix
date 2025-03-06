{pkgs, ...}: {
  home.packages = with pkgs; [ripgrep];
  programs.nixvim = {
    plugins.telescope.enable = true;
    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options = {
          desc = "search cwd files";
        };
      }
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>Telescope diagnostics<cr>";
        options = {
          desc = "lsp diagnostics";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options = {
          desc = "search live grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<cr>";
        options = {
          desc = "search recent files";
        };
      }
      {
        mode = "n";
        key = "<leader>fp";
        action = "<cmd>Telescope commands<cr>";
        options = {
          desc = "search commands";
        };
      }
      {
        mode = "n";
        key = "<C-p>";
        action = ":lua require'telescope.builtin'.git_files{use_git_root=false}<CR>";
        options = {
          desc = "search git repo";
        };
      }
      {
        mode = "n";
        key = "<C-f>";
        action = "<cmd>Telescope current_buffer_fuzzy_find <CR>";
        options = {
          desc = "current buffer fuzzy find";
        };
      }
    ];
  };
}
