{
	programs.zsh = { # To set zsh as default shell must be set by system
		enable = true;
		syntaxHighlighting.enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		profileExtra = "
			export PATH=\"$PATH:/Applications/Docker.app/Contents/Resources/bin/\"
		";
	};
}
