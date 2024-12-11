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
		openssh.authorizedKeys = {
			keys = [
				"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIZblT7Q/WxYTQnb3WL9lJMclp1DeQeYzdBKOBPAX0bD" # mbp14
			];
		};
  };

	# INFO: WSL STUFF

  wsl.enable = true;
  wsl.defaultUser = "mason";

	wsl.wslConf = {
    ws12 = {
      networkingMode = "mirrored";
    };

		network = {
			hostname = "wslonix"; # duped with nix, not sure if nix or wsl takes prio 
			generateResolvConf = false;
		};
  };

	# INFO: Link wsl library headers to path
	environment.variables = {
		# this includes things like libcuda and other GPU driver stuff
		# that we don't nixify in a regular way within WSL
		LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
	};

	# INFO: Networking stuff
	networking = {
		hostName = "wslonix";
		networkmanager.enable = true;
		nameservers = [ "8.8.8.8" "8.8.4.4" ];
	};

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = false;
		};
	};

	# INFO: Other
	services.openvscode-server = {
		enable = true;
		user = "mason";
	};
}
