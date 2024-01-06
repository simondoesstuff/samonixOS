{ config, pkgs, ... }:

let
	commonPackages = [ # Packages that are common to all platforms
		pkgs.cowsay
	];

	platformPackages = pkgs.lib.optionals pkgs.hostPlatform.isDarwin [
    (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Darwin!"'')
	] ++ pkgs.lib.optionals pkgs.hostPlatform.isWindows [
   (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Windows!"'')
	] ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
   (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Linux!"'')
	];
in
	{
		home = {
			#INFO: The user account and path that Home Manager will manage
			username = "mason";
			homeDirectory = "/Users/mason";

			#WARNING: You should not change this value, even if you update Home Manager. Check release notes if desired to change.
			stateVersion = "23.11";

			packages = commonPackages ++ platformPackages; # Combine the common and platform-specific packages to install

			# Home Manager is pretty good at managing dotfiles. The primary way to manage
			# plain files is through 'home.file'.
			file = {

				# # Building this configuration will create a copy of 'dotfiles/screenrc' in
				# # the Nix store. Activating the configuration will then make '~/.screenrc' a
				# # symlink to the Nix store copy.
				# ".screenrc".source = dotfiles/screenrc;

				# # You can also set the file content immediately.
				# ".gradle/gradle.properties".text = ''
				#   org.gradle.console=verbose
				#   org.gradle.daemon.idletimeout=3600000
				# '';
			};

			# Manage environment (shell) variables
			sessionVariables = {
				EDITOR = "neovim";
			};
		};

		nixpkgs.config.allowUnfree = true; # Allow unfree licensed packages, like discord


		nix = { # Configure the Nix package manager
			package = pkgs.nix;
			settings.experimental-features = [ "nix-command" ];
		};

		# Let Home Manager install and manage itself.
		programs.home-manager.enable = true;
	}
