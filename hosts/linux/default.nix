{
	imports = [
		./packages.nix
		./zsh.nix
		./rofi.nix
	] ++ [
		#INFO: Specified shared configs
		../shared/default.nix # In this case, take everything from shared
	];
}
