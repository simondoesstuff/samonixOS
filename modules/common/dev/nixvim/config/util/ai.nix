{ ... }:

{
  programs.nixvim = {
    # TODO: Copilot chat completion competes with blink-cmp completion.
    # Causes both menus to appear at times and is trash. Need fix
    plugins.copilot-chat = {
      enable = true;
      settings = {
        window.width = 0.4;
        mappings = {
          reset = {
            normal = "<leader>ar";
            insert = "";
          };
          close = {
            normal = "q";
            insert = "<C-q>"; # use ctrl-c to exit insert mode, don't want to close
          };
        };
      };
    };

    # Pretty sure there is no use for this plugin with blink-cmp
    # but could be useful to cycle ghost texts maybe
    # plugins.copilot-lua = {
    #   enable = true;
    #   settings = {
    #     panel.enabled = false;
    #     suggestion = {
    #       enabled = true;
    #       auto_trigger = true;
    #       hide_during_completion = false;
    #     };
    #   };
    # };

    keymaps = [
      # Copilot chat
      {
        mode = "n";
        key = "<leader>ac";
        action = "<cmd>CopilotChat<cr>";
        options.desc = "open chat";
      }
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
      # {
      #   mode = "i";
      #   key = "<C-l>";
      #   action.__raw = ''function() require("copilot.suggestion").accept() end'';
      #   options.desc = "accept copilot suggestion";
      # }
      # {
      #   mode = "i";
      #   key = "<C-k>";
      #   action.__raw = ''function() require("copilot.suggestion").prev() end'';
      #   options.desc = "next copilot suggestion";
      # }
      # {
      #   mode = "i";
      #   key = "<C-j>";
      #   action.__raw = ''function() require("copilot.suggestion").next() end'';
      #   options.desc = "prev copilot suggestion";
      # }
    ];
  };
}
