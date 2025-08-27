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
          bash = [
            "shellcheck"
            "shfmt"
          ];
          css = [ "prettierd" ];
          hbs = [ "prettierd" ];
          html = [ "prettierd" ];
          java = [ "google-java-format" ];
          javascript = [ "prettierd" ];
          markdown = [ "prettierd" ];
          lua = [ "stylua" ];
          python = [
            "ruff_organize_imports"
            "ruff_format"
            "ruff_fix"
          ];
          sh = [
            "shellcheck"
            "shfmt"
          ];
          svelte = [ "prettierd" ]; # set up https://github.com/sveltejs/prettier-plugin-svelte for formatting to work
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          rust = [ "rustfmt" ];
          toml = [ "taplo" ];
          yaml = [ "prettierd" ];

          # Applies to all files
          "*" = [ "codespell" ];
          # Applies to files with no preset formatter
          "_" = [ "trim_whitespace" ];
        };
        formatters = {
          google-java-format.command = lib.getExe pkgs.google-java-format;
          nixfmt.command = lib.getExe pkgs.nixfmt-rfc-style;
          stylua.command = lib.getExe pkgs.stylua;
          prettierd.command = lib.getExe pkgs.prettierd;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          codespell.command = lib.getExe pkgs.codespell;
          shfmt.command = lib.getExe pkgs.shfmt;
          shellcheck.command = lib.getExe pkgs.shellcheck;
          taplo.command = lib.getExe pkgs.taplo;
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
