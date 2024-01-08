{ pkgs,... }:

let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
	home.packages = with pkgs; (

	# General packages
	[
		fira-code-nerdfont # decent nerd font
		starship # Shell prompt
		wezterm # Terminal emulator
		lazygit # TUI git client
		neovim # text editor
	]

	# Language servers
	++ [
		lua-language-server # lua language serv
		rust-analyzer # rust language serv
		nil # nix language serv
	]

	# Linux specific packages
	# ++ lib.optionals isLinux [
	# 	(writeShellScriptBin "hello" ''echo "Hello from nix Linux!"'')
	#
	# # Darwin specific packages
	# ] ++ lib.optionals isDarwin [
 #  	(writeShellScriptBin "hello" ''echo "Hello from nix Darwin!"'')
	# ]
	);

}
