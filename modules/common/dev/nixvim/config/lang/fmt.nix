{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins.guess-indent.enable = true;
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = {
          timeout_ms = 2000;
          lsp_fallback = true;
        };
        default_format_opts.lsp_format = "fallback";
        formatters_by_ft = {
          lua = [ "stylua" ];
          python = [
            "ruff_organize_imports"
            "ruff_format"
            "ruff_fix"
            # "black"
            # "isort"
          ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          svelte = [ "prettierd" ]; # for svelte to work set up https://github.com/sveltejs/prettier-plugin-svelte
          html = [ "prettierd" ];
          rust = [ "rustfmt" ];
          nix = [ "nixfmt" ];
          "*" = [ "codespell -L crate" ];
          "_" = [ "trim_whitespace" ];
        };
        formatters = {
          nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
          stylua.command = lib.getExe pkgs.stylua;
          prettierd.command = lib.getExe pkgs.prettierd;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          # black.command = lib.getExe pkgs.black;
          # isort.command = lib.getExe pkgs.isort;
          codespell.command = lib.getExe pkgs.codespell;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        action = ''<cmd>lua require("conform").format({ async = true, lsp_fallback = true })<cr>'';
        key = "<leader>F";
        options.desc = "reformat";
      }
    ];
  };
}
