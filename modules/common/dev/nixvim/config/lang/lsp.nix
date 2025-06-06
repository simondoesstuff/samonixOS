{ pkgs, ... }:
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

    # general rust tooling & lsp
    rustaceanvim.enable = true;

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        lua_ls = {
          enable = true;
          settings = {
            workspace = {
              library = [
                # Computercraft-cc lua ls library
                "${
                  (pkgs.fetchgit {
                    url = "https://github.com/nvim-computercraft/lua-ls-cc-tweaked";
                    rev = "b23f104f55b5b3bee19d8fe647a04d9bd9943603"; # 3/14/25
                    sha256 = "sha256-tEePK0ilz57oiW0nsnUDB/hbcJqTYrY1FzQhfnc9694=";
                  })
                }/library"
                # nvim api for shi like vim.g being a valid global
                "${pkgs.neovim}/share/nvim/runtime/lua"
              ];
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
          # cmd = [
          #   "bunx"
          #   "tailwindcss-language-server"
          # ];
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

        # Javascript/html/css servers
        ts_ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;

        # Web frameworks
        svelte.enable = true;

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

        basedpyright = {
          enable = true;
          settings.basedpyright.analysis = {
            # typeCheckingMode = "basic";
            # useful if you want to try strict out
            # reportUnknownParameterType = false;
            # reportUnknownArgumentType = false;
          };
        };
        ruff.enable = true; # formatter and linter for python

        # dartls.enable = true; dont enable with flutter-tools
        clangd.enable = true;
        sourcekit.enable = true;
      };
    };
  };
}
