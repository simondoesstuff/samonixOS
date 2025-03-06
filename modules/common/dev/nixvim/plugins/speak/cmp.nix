{
  programs.nixvim.plugins = {
    copilot-lua.enable = true;
    # copilot-cmp.enable = true;

    blink-cmp = {
      enable = true;
      # autoLoad = true;
      settings.keymap.preset = "super-tab";
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
    };
  };
}
