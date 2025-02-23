{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  # INFO: Forward host interface to containers or something
  # Source: https://nixos.org/manual/nixos/stable/#sec-container-networking
  networking.networkmanager.unmanaged = ["interface-name:ve-*"];
  networking.nat = {
    enable = true;
    internalInterfaces = ["ve-+"]; # wildcard for all container interfaces
    externalInterface = "wlp59s0"; # host interface
  };

  containers.media = {
    autoStart = true;
    enableTun = true;
    privateNetwork = true;
    hostAddress = "192.168.10.1";
    localAddress = "192.168.10.2";

    forwardPorts = [
      {
        containerPort = 8096; # jellyfin
        hostPort = 8096;
        protocol = "tcp";
      }
      {
        containerPort = 5055; # jellyseerr
        hostPort = 5055;
        protocol = "tcp";
      }
      {
        containerPort = 8989; # sonarr
        hostPort = 8989;
        protocol = "tcp";
      }
    ];

    config = {
      environment.systemPackages = with pkgs; [dnsutils jellyfin jellyfin-web jellyfin-ffmpeg openvpn tcpdump];
      system.stateVersion = "24.11";

      # Networking
      networking = {
        nameservers = ["1.1.1.1" "8.8.8.8"];
        dhcpcd.enable = false;
        useHostResolvConf = false;
        nat = {
          enable = true;
          externalInterface = "wlp59s0";
          internalInterfaces = ["tun0"];
        };
        interfaces."eth0".ipv4.routes = [
          {
            address = "192.168.1.0";
            prefixLength = 24;
            via = "192.168.10.1";
          }
          {
            address = "192.168.68.0";
            prefixLength = 24;
            via = "192.168.10.1";
          }
        ];
        # Firewall to prevent leaks outside of vpn by only accepting marked traffic
        firewall = {
          enable = false;
          allowedUDPPorts = [1194]; # Standard OpenVPN port
          allowedTCPPorts = [8096 5055 8989];
          interfaces = {
            "eth0".allowedTCPPorts = [8096 5055 8989];
            "tun".allowedTCPPorts = [8096 5055 8989];
          };
          # Reject all traffic not going through VPN
          extraCommands = ''
            # Allow loopback and initial VPN connection
            iptables -A OUTPUT -o lo -j ACCEPT
            iptables -A OUTPUT -p udp --dport 1194 -j ACCEPT
            iptables -A OUTPUT -m addrtype --dst-type MULTICAST -j ACCEPT

            # Allow traffic to the host over container interface
            iptables -A OUTPUT -d 192.168.10.1 -o ve-+ -j ACCEPT

            # Allow established/related connections
            iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

            # Mark packets going through tun0 (VPN interface)
            iptables -t mangle -A OUTPUT -o tun0 -j MARK --set-mark 0x1234

            # Allow marked traffic
            iptables -A OUTPUT -m mark --mark 0x1234 -j ACCEPT

            # Reject everything else
            iptables -A OUTPUT -j REJECT
          '';
        };
      };

      # VPN service
      services.openvpn.servers.mediaVPN = {
        updateResolvConf = true;
        authUserPass.username = lib.removeSuffix "\n" (builtins.readFile ./nordUser.key);
        authUserPass.password = lib.removeSuffix "\n" (builtins.readFile ./nordPass.key);
        config = builtins.readFile ./us9444.nordvpn.com.udp.ovpn.key;
      };

      nixpkgs.config.permittedInsecurePackages = [
        "aspnetcore-runtime-wrapped-6.0.36"
        "aspnetcore-runtime-6.0.36"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-sdk-6.0.428"
      ];

      # Media stuff
      users.groups.media = {}; # Ensures the 'media' group is created
      systemd.tmpfiles.rules = [
        "d /srv/media 2775 root media -"
        "d /srv/transmission 2775 root media -"
        "d /srv/transmission/tv-sonarr 2775 root media -"
      ];

      services.jellyfin = {
        enable = true;
        openFirewall = true; # port 8096
        group = "media";
      };

      services.jellyseerr = {
        enable = true;
        openFirewall = true; # port 5055
      };

      services.sonarr = {
        enable = true;
        openFirewall = true; # port 8989
        group = "media";
      };

      services.radarr = {
        enable = true;
        openFirewall = true; # port 7878
        group = "media";
      };

      services.prowlarr = {
        enable = true;
        openFirewall = true; # port 9696
        package = pkgs-unstable.prowlarr;
      };

      services.transmission = {
        enable = true; #Enable transmission daemon
        openFirewall = true; # port 9091
        openRPCPort = true; # opens firewall for RPC
        package = pkgs.transmission_4-qt;
        group = "media";
        settings = {
          rpc-bind-address = "0.0.0.0"; #Bind to own IP
          rpc-whitelist = "127.0.0.1,192.168.10.1"; # Whitelist container host 192.168.1.1
          download-dir = "/srv/transmission";
          ratio-limit-enabled = true;
          download-queue-size = 11;
          ratio-limit = 0.1;
        };
      };

      # Hack to get transmission proper directory rights to mount
      systemd.services.transmission.serviceConfig = {
        RootDirectoryStartOnly = lib.mkForce false;
        RootDirectory = lib.mkForce "";
      };
    };
  };
}
