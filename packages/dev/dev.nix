{ pkgs,... }:

let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
	xdg.configFile.nvim = {
		source = ../../config/neovim;
		recursive = true;
	}; # Source neovim config

	xdg.configFile.wezterm = {
		source = ../../config/wezterm;
		recursive = true;
	}; # Source wezterm config

	home.packages = with pkgs; (
		# General packages
		[
			fira-code-nerdfont # decent nerd font
			lazygit # TUI git client
			neovim # text editor
			neofetch # Show os info and such
		]

		# Simple linux hey bash script
		++ lib.optionals isLinux [
			(writeShellScriptBin "hey" ''echo "Hey, from nix Linux!"'')
		] 

		# Simple darwin hey bash script
		++ lib.optionals isDarwin [
			(writeShellScriptBin "hey" ''echo "Hey, from nix Darwin!"'')
		]

	);
}
