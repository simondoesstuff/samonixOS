{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userName = "masoniis";
		userEmail = "bott.m@comcast.net";
	};
}
