{pkgs, ...}: {
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
          # TODO: Snacks rename support not working
          #  event_handlers.__raw = ''
          #    (function()
          #      local events = require("neo-tree.events")
          #      return {
          #        {
          #          event = events.FILE_MOVED,
          # handler = function(data)
          # 	local source = vim.fn.fnamemodify(data.source, ":p")
          # 	local destination = vim.fn.fnamemodify(data.destination, ":p")
          # 	vim.notify(("Calling Snacks with:\nSRC: %s\nDEST: %s"):format(source, destination))
          # 	require("snacks.rename").on_rename_file(source, destination)
          # end
          #        },
          #        {
          #          event = events.FILE_RENAMED,
          # handler = function(data)
          # 	local source = vim.fn.fnamemodify(data.source, ":p")
          # 	local destination = vim.fn.fnamemodify(data.destination, ":p")
          # 	vim.notify(("Calling Snacks with:\nSRC: %s\nDEST: %s"):format(source, destination))
          # 	require("snacks.rename").on_rename_file(source, destination)
          # end
          #        }
          #      }
          #    end)()
          #  '';
          nesting_rules.__raw = ''require('neotree-file-nesting-config').nesting_rules'';
          window.mappings = {
            "<S-CR>" = {
              command = "toggle_node";
            };
          };
        };
      };
    };

    keymaps = [
      {
        action = "<cmd>Neotree toggle source=filesystem reveal=true position=left<cr>";
        mode = "n";
        key = "<leader>e";
        options.desc = "explorer";
      }
    ];

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "neotree-file-nesting-config";
        src = pkgs.fetchFromGitHub {
          owner = "saifulapm";
          repo = "neotree-file-nesting-config";
          rev = "089adb6d3e478771f4485be96128796fb01a20c4";
          sha256 = "VCwujwpiRR8+MLcLgTWsQe+y0+BYL9HRZD+OzafNGGA=";
        };
      })
    ];
  };
}
