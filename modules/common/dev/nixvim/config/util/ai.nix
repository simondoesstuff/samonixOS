# https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file
{ ... }:

{
  programs.nixvim = {
    plugins.copilot-chat = {
      enable = true;
      settings.mappings = {
        reset = {
          normal = "<leader>ar";
          insert = "<leader>ar";
        };
      };
    };

    plugins.copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        # TODO: Get ghost text working again, and use the binds below to navigate
        suggestion = {
          enabled = false;
          auto_trigger = true;
          hide_during_completion = false;
        };
      };
    };

    keymaps = [
      # Copilot chat
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>CopilotChat<cr>";
        options.desc = "open chat";
      }
      # TODO: Open copilot chat with selection as an input
      {
        mode = "v";
        key = "<leader>ac";
        action = "<cmd>CopilotChat<cr>";
        options.desc = "open copilot chat";
      }
      # Copilot lua
      {
        mode = "i";
        key = "<C-l>";
        action.__raw = ''function() require("copilot.suggestion").accept() end'';
        options.desc = "accept copilot suggestion";
      }
      {
        mode = "i";
        key = "<C-k>";
        action.__raw = ''function() require("copilot.suggestion").prev() end'';
        options.desc = "next copilot suggestion";
      }
      {
        mode = "i";
        key = "<C-j>";
        action.__raw = ''function() require("copilot.suggestion").next() end'';
        options.desc = "prev copilot suggestion";
      }
    ];
  };
}
