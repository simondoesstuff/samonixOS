{pkgs, ...}: {
  home.packages = with pkgs; [
    # tailwindcss-language-server
    # svelte-language-server
    # nodePackages.svelte-language-server
  ];

  programs.nixvim = {
    plugins.treesitter = {
      enable = true;
      settings = {
        ensure_installed = "all";
        ignore_install = ["norg"];
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        incremental_selection.enable = true;
        indent.enable = true;
      };
    };

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
          # TODO: Need to create a cmd selection function.
          # If bunx exist, use that, otherwise node, etc
          cmd = ["bunx" "tailwindcss-language-server"];
          extraOptions = {
            on_init = {
              __raw = ''
                function(client)
                  client.config.settings.tailwindCSS = {
                    experimental = { classRegex = { "class:?\\s*'([^']*)'" } }
                  }
                end
              '';
            };
          };
        };

        svelte = {
          enable = true;
          # cmd = ["svelteserver" "--stdio"];
        };

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
        # dartls.enable = true; dont enable with flutter-tools
        clangd.enable = true;
        sourcekit.enable = true;
      };
    };

    # Also add the autocommand for floating diagnostics
    extraConfigLua = ''
      vim.diagnostic.config({
      	virtual_text = true,
      	signs = true,
      	underline = false,
      	severity_sort = true,
      	update_in_insert = false,
      })

      -- vim.o.updatetime = 250
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
      	callback = function()
      		vim.diagnostic.open_float(nil, { focus = false })
      	end
      })

      vim.api.nvim_create_autocmd("LspAttach", {
      	callback = function(args)
      		local bufnr = args.buf
      		local client = vim.lsp.get_client_by_id(args.data.client_id)
      		if client.supports_method("textDocument/completion") then
      			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      		end
      		if client.supports_method("textDocument/definition") then
      			vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
      		end
      		--INFO: LSP keybinds defined here
      		vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "see declaration" })
      		vim.keymap.set("n", "<leader>lK", vim.lsp.buf.hover, { buffer = bufnr, desc = "hover action" })
      		vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { buffer = bufnr, desc = "see definition" })
      		vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { buffer = bufnr, desc = "see implementation" })
      		vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "type definition" })
      		vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = bufnr, desc = "rename symbol" })
      		vim.keymap.set("n", "<leader>la", require("actions-preview").code_actions,
      			{ buffer = bufnr, desc = "code action menu" })

      		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = bufnr, desc = "references" })
      		vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end,
      			{ buffer = bufnr, desc = "diagnostics float" })
      		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "hover action" })
      	end,
      })
    '';
  };
}
