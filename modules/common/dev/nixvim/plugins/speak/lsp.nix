{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        lua_ls.settings.Lua.workspace.library = [
          "/Users/mason/dev/computercraft/ccls/library"
        ];

        nixd.enable = true;
        nil_ls.enable = true;

        tailwindcss = {
          enable = true;
          cmd = ["bunx" "tailwindcss-language-server"];
          extraOptions = {
            on_init = ''
              function(client)
                client.config.settings.tailwindCSS = {
                  experimental = { classRegex = { "class:?\\s*'([^']*)'" } }
                }
              end
            '';
          };
        };

        svelte.enable = true;
        ts_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;

        glsl_analyzer = {
          enable = true;
          filetypes = ["glsl" "vert" "tesc" "tese" "frag" "geom" "comp" "fsh" "vsh"];
          extraOptions = {
            on_attach = {
              __raw = ''
                function(client, _)
                  client.cancel_request = function(_, _) end -- do nothing avoiding error message
                end
              '';
            };
          };
        };

        pylsp.enable = true;
        dartls.enable = true;
        clangd.enable = true;
        sourcekit.enable = true;
      };

      # This is where you replicate the capabilities modification
      # capabilities = ''
      #   require('blink.cmp').get_lsp_capabilities(capabilities)
      # '';

      # Diagnostic configuration
      # diagnostics = {
      #   underline = false;
      #   update_in_insert = false;
      #   virtual_text.enable = true;
      #   signs.enable = true;
      #   severity_sort = true;
      # };
    };

    # Also add the autocommand for floating diagnostics
    extraConfigLua = ''
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function()
          vim.diagnostic.open_float(nil, { focus = false })
        end
      })
    '';

    keymaps = [
      {
        mode = "n";
        key = "<leader>lD";
        action = "<cmd>lua vim.lsp.buf.declaration()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "see declaration";
        };
      }
      {
        mode = "n";
        key = "<leader>lK";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "hover action";
        };
      }
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>lua vim.lsp.buf.definition()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "see definition";
        };
      }
      {
        mode = "n";
        key = "<leader>li";
        action = "<cmd>lua vim.lsp.buf.implementation()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "see implementation";
        };
      }
      {
        mode = "n";
        key = "<leader>lt";
        action = "<cmd>lua vim.lsp.buf.type_definition()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "type definition";
        };
      }
      {
        mode = "n";
        key = "<leader>ln";
        action = "<cmd>lua vim.lsp.buf.rename()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "rename symbol";
        };
      }
      {
        mode = "n";
        key = "<leader>la";
        action = "<cmd>lua require('actions-preview').code_actions()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "code action menu";
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>lua vim.lsp.buf.references()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "references";
        };
      }
      {
        mode = "n";
        key = "<leader>lf";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "diagnostics float";
        };
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options = {
          buffer = {__raw = "vim.api.nvim_get_current_buf()";};
          desc = "hover action";
        };
      }
    ];

    # Don't forget your other plugins
    # extraPlugins = [
    #   # You can add these as plugins in nixvim
    #   "aznhe21/actions-preview.nvim"
    #   "folke/neoconf.nvim"
    #   "folke/neodev.nvim"
    #   "saghen/blink.cmp"
    #   {
    #     plugin = "j-hui/fidget.nvim";
    #     config = ''
    #       require("fidget").setup({})
    #     '';
    #   }
    # ];
  };
}
