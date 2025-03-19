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
          timeout_ms = 500;
          lsp_fallback = true;
        };
        default_format_opts.lsp_format = "fallback";
        formatters_by_ft = {
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          javascript = [ "prettierd" ];
          typescript = [ "prettierd" ];
          typescriptreact = [ "prettierd" ];
          html = [ "prettierd" ];
          rust = [ "rustfmt" ];
          nix = [ "alejandra" ];
        };
        formatters = {
          alejandra.command = lib.getExe pkgs.alejandra;
          stylua.command = lib.getExe pkgs.stylua;
          prettierd.command = lib.getExe pkgs.prettierd;
          rustfmt.command = lib.getExe pkgs.rustfmt;
          black.command = lib.getExe pkgs.black;
          isort.command = lib.getExe pkgs.isort;
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
