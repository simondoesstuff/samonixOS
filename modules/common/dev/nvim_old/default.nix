{
  pkgs-unstable,
  config,
  pkgs,
	lib,
  ...
}: {
	imports = [./language];

  config = lib.mkIf config.legacyNvim.enable {
		home.sessionVariables = {
			EDITOR = "nvim";
		};

		# Source neovim/wezterm custom (non-nix) config
		xdg.configFile.nvim = {
			source = config.lib.file.mkOutOfStoreSymlink ./neovim;
			recursive = true;
		};

		home.packages = [
			pkgs-unstable.neovim # Cracked text editor
			pkgs.tree-sitter # Syntax highlighting
			pkgs.ripgrep # Fast grep
			pkgs.fd # Advanced find
		];

		# file nav system used in neovim
		programs.yazi = {
			enable = true;
			enableZshIntegration = true;
			plugins = {
				starship = pkgs.fetchFromGitHub {
					owner = "Rolv-Apneseth";
					repo = "starship.yazi";
					rev = "20d5a4d4544124bade559b31d51ad41561dad92b";
					sha256 = "sha256-0nritWu53CJAuqQxx6uOXMg4WiHTVm/i78nNRgGrlgg=";
				};
			};
			initLua = ''
				require("starship"):setup()
			'';
		};
	};
}
