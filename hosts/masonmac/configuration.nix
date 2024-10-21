# { pkgs, lib, inputs, ... }:
{ ... }:
{
	system.stateVersion = 5;
	services.nix-daemon.enable = true;
	users.users."mason".home = "/Users/mason";
}
