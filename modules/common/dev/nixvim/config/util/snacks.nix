{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    imagemagick
    tectonic
    mermaid-cli
    ghostscript
  ];

  programs.nixvim = {
    plugins.neoscroll.enable = true; # better than snacks scroll imo
    plugins.snacks = {
      enable = true;
      settings = {
        quickfile.enabled = true;
        scroll.enabled = false;
        statuscolumn.enabled = true;
        notifier.enabled = true;
        picker.enabled = true;
        lazygit.enabled = true;
        input.enabled = true;
        indent.enabled = true;
        image.enabled = true;
      };
    };

    keymaps = [
      # INFO: Snacks pickers
      {
        mode = "n";
        key = "<leader><leader>";
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
        key = "<leader>/";
        action = "<cmd>lua Snacks.picker.grep()<cr>";
        options.desc = "grep";
      }
      {
        mode = "n";
        key = "<leader>f:";
        action = "<cmd>lua Snacks.picker.command_history()<cr>";
        options.desc = "commands";
      }
      {
        mode = "n";
        key = "<leader>fn";
        action = "<cmd>lua Snacks.picker.notifications()<cr>";
        options.desc = "notifications";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>lua Snacks.picker.recent()<cr>";
        options.desc = "recent files";
      }

      # INFO: Rename using snacks
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua Snacks.rename.rename_file()<cr>";
        options.desc = "rename file";
      }
    ];
  };
}
