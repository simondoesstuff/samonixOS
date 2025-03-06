{
  programs.nixvim = {
    plugins.blink-cmp = {
      enable = true;
      settings.sources = {
        copilot = {
          async = true;
          module = "blink-cmp-copilot";
          name = "copilot";
          score_offset = 100;
        };
      };
      settings.sources.default = [
        "lsp"
        "path"
        "snippets"
        "buffer"
        "copilot"
      ];
    };
  };
}
