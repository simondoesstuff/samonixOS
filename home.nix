{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mason";
  home.homeDirectory = "/Users/mason";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
	nixpkgs.config.allowUnfree = true;

	home.packages = pkgs.lib.optionals pkgs.hostPlatform.isDarwin [
    (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Darwin!"'')
		pkgs.cowsay
  ] ++ pkgs.lib.optionals pkgs.hostPlatform.isWindows [
    (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Windows!"'')
		pkgs.cowsay
  ] ++ pkgs.lib.optionals pkgs.hostPlatform.isLinux [
    (pkgs.writeShellScriptBin "hello" ''echo "Hello, ${config.home.username}, from nix Linux!"'')
		pkgs.cowsay
  ];

  # home.packages = [ # CAN BE FOUND AT https://search.nixos.org/packages
  #   # # Adds the 'hello' command to your environment. It prints a friendly
  #   # # "Hello, world!" when run.
  #   pkgs.hello
		# pkgs.cowsay
  #
		# 
		# # Adds custom command to print hello
  #   (pkgs.writeShellScriptBin "my-hello" ''
  #     echo "Hello, ${config.home.username}!"
  #   '')
  # ];

	nix = {
  	package = pkgs.nix;
  	settings.experimental-features = [ "nix-command" ];
	};

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mason/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
