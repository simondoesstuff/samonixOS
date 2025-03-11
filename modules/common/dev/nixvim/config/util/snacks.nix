{pkgs, ...}: {
  home.packages = with pkgs; [ripgrep];
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "snacks";
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "snacks.nvim";
          rev = "bc0630e43be5699bb94dadc302c0d21615421d93";
          sha256 = "Gw0Bp2YeoESiBLs3NPnqke3xwEjuiQDDU1CPofrhtig=";
        };
      })
    ];

    extraConfigLua = ''
      require("snacks").setup({})
    '';

    keymaps = [
      # Top Pickers & Explorer
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>lua Snacks.picker.smart()<cr>";
        options.desc = "find files";
      }
      {
        mode = "n";
        key = "<leader>f,";
        action = "<cmd>lua Snacks.picker.buffers()<cr>";
        options.desc = "find buffers";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "grep";
      }
      {
        mode = "n";
        key = "<leader>f:";
        action = "<cmd>lua Snacks.picker.command_history()<cr>";
        options.desc = "Command History";
      }
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>lua Snacks.picker.notifications()<cr>";
        options.desc = "Notification History";
      }
    ];
  };
}
