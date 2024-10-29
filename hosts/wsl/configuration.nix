# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  ...
}: {
  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  wsl.enable = true;
  wsl.defaultUser = "mason";

	wsl.wslConf = {
		# https://randombytes.substack.com/p/bridged-networking-under-wsl
    ws12 = {
      networkingMode = "bridged";
      vmSwitch = "WSLBridge"; #INFO: Name of hyper-v bridge in windows
			dhcp = "false";
			ipv6 = "true";
    };
  };

  users.users.mason = {
		ignoreShellProgramCheck = true; # shell is defined via home-manager
		shell = pkgs.zsh;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings.PasswordAuthentication = true;
	};
}
