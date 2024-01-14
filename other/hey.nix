{ pkgs,... }:

let
	isLinux = pkgs.stdenv.hostPlatform.isLinux;
	isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
	home.packages = with pkgs; (
		# Simple linux hey bash script
		lib.optionals isLinux [
			(writeShellScriptBin "hey" ''echo "Hey, from nix Linux!"'')
		] 

		# Simple darwin hey bash script
		++ lib.optionals isDarwin [
			(writeShellScriptBin "hey" ''echo "Hey, from nix Darwin!"'')
		]

	);
}
