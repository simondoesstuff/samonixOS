{pkgs, ...}: {
  home.packages = with pkgs; [lolcat];
  programs.nixvim.plugins = {
    copilot-lua.enable = true;
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {name = "path";}
          {name = "buffer";}
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";

          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";

          "<Tab>" = "cmp.mapping.confirm({ select = true })"; # Makes Tab confirm the selection
        };
      };
    };
    # blink-cmp = {
    #   enable = true;
    #   autoLoad = true;
    #   settings.windows.documentation.auto_show = true;
    #   settings.keymap.preset = "super-tab";
    #   settings.sources = {
    #     copilot = {
    #       async = true;
    #       module = "blink-cmp-copilot";
    #       name = "copilot";
    #       score_offset = 100;
    #       transform_items = {
    #         __raw = ''
    #           function(_, items)
    #           	local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
    #           	local kind_idx = #CompletionItemKind + 1
    #           	CompletionItemKind[kind_idx] = "Copilot"
    #           	for _, item in ipairs(items) do
    #           		item.kind = kind_idx
    #           	end
    #           	return items
    #           end
    #         '';
    #       };
    #     };
    #   };
    #   settings.sources.default = [
    #     "lsp"
    #     "path"
    #     "snippets"
    #     "buffer"
    #     "copilot"
    #   ];
    #   settings.completion = {
    #     keyword = {range = "prefix";}; # full looks ahead for fuzzy matching
    #     ghost_text = {enabled = true;};
    #     menu = {
    #       border = "single";
    #       draw = {
    #         columns = [
    #           [
    #             "label"
    #             "label_description"
    #             {gap = 1;}
    #           ]
    #           [
    #             "kind_icon"
    #             {gap = 1;}
    #             "kind"
    #           ]
    #         ];
    #       };
    #     };
    #   };
    # };
  };
}
