{ ... }:

{
	#INFO: Import all configs and packages from external files
	imports = [
		./git.nix
		./nvim.nix
		./wezterm.nix
		./packages.nix
		./starship.nix
		./direnv.nix
		./zoxide.nix
		./eza.nix
		./glfw.nix

		# Import all language servers
		./language/default.nix
  ];
}
