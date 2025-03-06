{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "colorful-winsep";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-zh";
          repo = "colorful-winsep.nvim";
          rev = "0070484536ea55ec64a8453d41e3badace04a61a";
          sha256 = "OlddU0ehlkbrLzI+Wsq53azzT72HP+75UsaVqIziSvs=";
        };
      })
    ];

    extraConfigLua = ''
        require("colorful-winsep").setup({
        	-- Winsep color
        	highlight = {
        		bg = "#171720",
        		fg = "#EDC4E5",
        	},
        	no_exec_files = { "packer", "TelescopePrompt", "mason", "CompetiTest", "NvimTree" },
        	-- Symbols: hor, vert, top left, top right, bot left, bot right.
        	symbols = { "━", "┃", "┏", "┓", "┗", "┛" },
        })

        vim.cmd("highlight WinSeparator guifg=#EDC4E5")
      '';
  };
}
