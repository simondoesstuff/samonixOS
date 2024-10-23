# Hosts
| Host | Personal purpose |
| --- | --- |
| xps | Dell xps17 laptop running NixOS |
| masonmac | MPB 14" M1 Pro on macos using home-manager[^1] |
| wsl | General WSL nix-os configuration |

[^1]: Currently using home-manager without darwin to manage mac. I don't think I personally need the system configuration settings and nix-darwin previously broke my nix setup so I decided to opt out of using it.
## Usage
Since the hosts have a mix of `home-manager` exclusive configurations as well as `nixos` configurations that automatically include `home-manager` modules, the setup can vary slightly on a fresh machine.

- Macos with home-manager: install nix using determinate nix installer, then follow the flake section of the [home-manager guide](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes)
- Nixos config: Run
```bash
sudo nixos-rebuild switch --flake .#host@user
```
