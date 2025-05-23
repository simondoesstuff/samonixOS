{
  programs.nixvim.extraConfigLua = builtins.readFile ./lsp.lua;
  programs.nixvim.plugins = {
    inc-rename.enable = true;

    treesitter = {
      enable = true;
      settings = {
        ensure_installed = "all";
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        incremental_selection.enable = true;
        indent.enable = true;
        foldexpr.enable = true;
      };
    };

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              workspace = {
                # TODO: Fetch this using fetchgit
                library = [ "/Users/mason/dev/computercraft/ccls/library" ];
              };
            };
          };
        };

        # TODO: drip out nix language server setup
        # nixd.enable = true;
        nil_ls.enable = true;

        tailwindcss = {
          enable = true;
          # TODO: Need to create a cmd selection function.
          # If bunx exist, use that, otherwise node, etc
          cmd = [
            "bunx"
            "tailwindcss-language-server"
          ];
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
          # cmd = [
          #   "bunx"
          #   "svelteserver"
          #   "--stdio"
          # ];
        };

        ts_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;

        glsl_analyzer = {
          enable = true;
          filetypes = [
            "glsl"
            "vert"
            "tesc"
            "tese"
            "frag"
            "geom"
            "comp"
            "fsh"
            "vsh"
          ];
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
        pylsp.settings = {
          plugins = {
            # TODO: jedi be doing nothing sadly
            jedi_completion = {
              enabled = true;
            };
            pycodestyle = {
              enabled = true;
            };
            pylsp_rope = {
              enabled = true;
            };
            pylint = {
              enabled = true;
            };
          };
        };
        # jedi_language_server.enable = true;
        # dartls.enable = true; dont enable with flutter-tools
        clangd.enable = true;
        sourcekit.enable = true;
      };
    };
  };
}
