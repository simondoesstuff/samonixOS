{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
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
          ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          svelte = [ "prettierd" ]; # for svelte to work set up https://github.com/sveltejs/prettier-plugin-svelte
          html = [ "prettierd" ];
          rust = [ "rustfmt" ];
          markdown = [ "prettierd" ];
          sh = [
            "shellcheck"
            "shfmt"
          ];
          bash = [
            "shellcheck"
            "shfmt"
          ];
          "*" = [ "codespell" ];
          "_" = [ "trim_whitespace" ];
        };
        formatters = {
          nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
          stylua.command = lib.getExe pkgs.stylua;
          prettierd.command = lib.getExe pkgs.prettierd;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          codespell.command = lib.getExe pkgs.codespell;
          shfmt.command = lib.getExe pkgs.shfmt;
          shellcheck.command = lib.getExe pkgs.shellcheck;
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
