{ config, pkgs, ... }:

{
	home = {
		#INFO: The user account and path that Home Manager will manage
		username = "mason";
		homeDirectory = if pkgs.hostPlatform.isDarwin then "/Users/mason" else "/home/mason";

		#WARNING: You should not change this value, even if you update Home Manager. Check release notes if desired to change.
		stateVersion = "23.11";

		packages = [
			pkgs.neovim # text editor
			pkgs.lazygit # TUI git client
			pkgs.fira-code-nerdfont # monospace font with symbols and ligatures
			pkgs.starship # Shell prompt
			pkgs.lua-language-server # implied
			pkgs.rust-analyzer
		] ++ pkgs.lib.optionals pkgs.hostPlatform.isDarwin [
  		(pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Darwin!"'')
			pkgs.wezterm # Mac linux terminal
		] ++ pkgs.lib.optionals pkgs.hostPlatform.isWindows [
		 (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Windows!"'')
		] ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
		 (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Linux!"'')
			pkgs.wezterm # Mac linux terminal
		];
		# Manage environment (shell) variables
		sessionVariables = {
			EDITOR = "neovim";
		};
	};

	imports = [ # Import exterior configs
		./extra/git.nix 
		./extra/shell.nix 
		./extra/config.nix 
	];

	fonts.fontconfig.enable = true; # Enable fonts
	nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord

	nix = { # Configure the Nix package manager itself
		package = pkgs.nix;
		settings.experimental-features = [ "nix-command" ];
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
