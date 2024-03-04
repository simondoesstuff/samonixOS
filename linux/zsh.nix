{
	programs.zsh = { # To set zsh as default shell must be set by system
		enable = true;
		syntaxHighlighting.enable = true;
		enableAutosuggestions = true;
		enableCompletion = true;
		# Added to (end) of .zprofile
		profileExtra = "
			export PATH=\"$PATH:/Applications/Docker.app/Contents/Resources/bin/\"
		";
		# Added to (end) of .zshrc, init zoxide
		#alias gsed='sed'
		initExtra = "
			eval \"$(zoxide init zsh --cmd cd)\"
		";
	};
}
