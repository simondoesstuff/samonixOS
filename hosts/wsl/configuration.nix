# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  pkgs,
  ...
}: {
  # WARNING: Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {
    package = pkgs.nix;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  nixpkgs.config.allowUnfree = true;

  users.users.mason = {
		ignoreShellProgramCheck = true; # shell is defined via home-manager
		shell = pkgs.zsh;
  };

	# INFO: WSL STUFF

  wsl.enable = true;
  wsl.defaultUser = "mason";

	wsl.wslConf = {
		# https://randombytes.substack.com/p/bridged-networking-under-wsl
    ws12 = {
      networkingMode = "bridged";
      vmSwitch = "WSLBridge"; #INFO: Name of hyper-v bridge in windows
			dhcp = "true" ;
			# ipv6 = "false";
    };

		network = {
			generateResolveConf = false;
		};
  };

	# INFO: Networking stuff
	networking = {
		# networkmanager.enable = true;
		nameservers = [ "8.8.8.8" "8.8.4.4" ];
	};

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = false;
		};
	};

}
