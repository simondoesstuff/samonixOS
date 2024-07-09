# This config is just a general darwin config
{
	imports = [
		#INFO: Darwin exclusive configs
		./entertainment.nix
		./packages.nix
		./zsh.nix
	] ++ [
		#INFO: Specified shared configs
		../shared/default.nix # In this case, take everything from shared
	];
}
