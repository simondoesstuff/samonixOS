{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "colorful-menu";
        src = pkgs.fetchFromGitHub {
          owner = "xzbdmw";
          repo = "colorful-menu.nvim";
          # 4/10/2025
          rev = "f80feb8a6706f965321aff24d0ed3849f02a7f77";
          sha256 = "sha256-nLrxL/eVELFfqmoT+2qj1yJb4S6DjtCg9b5B9o73RuY=";
        };
      })
    ];

    plugins = {
      friendly-snippets.enable = true;
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          exit_roots = false;
          keep_roots = true;
          link_roots = true;
          update_events = [
            "TextChanged"
            "TextChangedI"
          ];
        };
      };
      copilot-cmp.settings.fix_pairs = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "copilot"; }
            { name = "ai"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          formatting = {
            format.__raw = ''
              				function(entry, vim_item)
                          local highlights_info = require("colorful-menu").cmp_highlights(entry)
                          if highlights_info ~= nil then
                              vim_item.abbr_hl_group = highlights_info.highlights
                              vim_item.abbr = highlights_info.text
                          end

                          return vim_item
                      end
              				'';
          };
          mapping = {
            # "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "function() if cmp.visible() then cmp.abort() else cmp.complete() end end";
            "<CR>" =
              #Lua
              ''
                cmp.mapping({
                  i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                      fallback()
                    end
                  end,
                  s = cmp.mapping.confirm({ select = true }),
                  c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                })
              '';

            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";

            "<Tab>" =
              # Lua
              ''
                cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                  elseif cmp.visible() then
                    cmp.confirm({ select = true })
                  else
                    fallback()
                  end
                end, {'i', 's'})
              '';

            "<S-Tab>" =
              # Lua
              ''
                cmp.mapping(function(fallback)
                  local luasnip = require('luasnip')
                  if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                  else
                    fallback()
                  end
                end, {'i', 's'})
              '';
          };
        };
      };

      # colorful-menu.enable = true;
      # TODO: Blink cmp more capable than nvim-cmp but for some reason not
      # properly working with nixvim (colors aren't coming through and such)
      blink-cmp = {
        enable = false;
        autoLoad = true;
        settings = {
          keymap.preset = "super-tab";
          ghost_text.enable = true;
          snippets = {
            preset = "luasnip";
          };
          sources.default = [
            "copilot"
            "snippets"
            "lsp"
            "path"
            "buffer"
          ];
          appearance = {
            nerd_font_variant = "normal";
            use_nvim_cmp_as_default = true;
          };
          completion = {
            menu = {
              draw = {
                columns = [
                  { kind_icon = { }; }
                  {
                    label = {
                      gap = 1;
                    };
                  }
                ];
                components = {
                  label = {
                    text = {
                      __raw = ''
                        function(ctx)
                          return require("colorful-menu").blink_components_text(ctx)
                        end
                      '';
                    };
                    highlight = {
                      __raw = ''
                        function(ctx)
                          return require("colorful-menu").blink_components_highlight(ctx)
                        end
                      '';
                    };
                  };
                };
              };
            };
          };
        };
      };
    };

    extraConfigLua = ''
      require("luasnip.loaders.from_vscode").lazy_load()
      require("colorful-menu").setup()
    '';
  };
}
