# https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file
{ ... }:

{
  programs.nixvim = {
    # TODO: Copilot chat completion is not working for adding files, buffers, etc
    plugins.copilot-chat = {
      enable = true;
      settings = {
        model = "claude-3.7-sonnet-thought";
        window.width = 0.4;
        mappings = {
          reset = {
            normal = "<leader>ar";
            insert = "<leader>ar";
          };
        };
      };
    };

    plugins.copilot-lua = {
      enable = true;
      settings = {
        panel.enabled = false;
        # TODO: Ghost text is very useful but cmp doesn't like it, integrate into cmp (or switch to blink)
        suggestion = {
          enabled = true;
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
      {
        mode = "n";
        key = "<leader>al";
        action = "<cmd>CopilotChatModels<cr>";
        options.desc = "view chat model list";
      }
      {
        mode = "n";
        key = "<leader>ar";
        action = "<cmd>CopilotChatReset<cr>";
        options.desc = "reset copilot chat";
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
