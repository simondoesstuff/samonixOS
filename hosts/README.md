# Hosts
| Host | Personal purpose |
| --- | --- |
| [xps](./xps/default.nix)           | Dell xps17 laptop running NixOS |
| [masonmac](./masonmac/default.nix) | MPB 14" M1 Pro on MacOS using home-manager[^1] |
| [wsl](./wsl/default.nix)           | Generalized [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) configuration |

[^1]: Currently using `home-manager` without `nix-darwin` to manage mac. I don't think I personally need the system configuration settings and `nix-darwin` previously broke my nix setup so I decided to opt out of using it.

## Usage
Since the hosts have a mix of `home-manager` exclusive configurations as well as `nixos` configurations that automatically include `home-manager` modules, the setup can vary slightly on a fresh machine.
### NixOS configs with built-in home-manager
```bash
sudo nixos-rebuild switch --flake .#host@user
```
### MacOS with exclusive home-manager
- Macos with home-manager: install nix using determinate nix installer, then follow the flake section of the [home-manager guide](https://nix-community.github.io/home-manager/index.xhtml#ch-nix-flakes). Currently, this is just running (where `<branch>` is the desired version, eg `master`):
```
nix run home-manager/<branch> -- init --switch
```
## Available options when creating new hosts
Hosts can set config options such as `entertainment.enable = true;`. The following is a list of options available and what they do.

| Option | Description | Default |
| --- | --- | --- |
| `entertainment.enable` | Enable entertainment packages related to media (currently darwin only) | `false` |
| `personal.enable` | Enable personal [packages](../modules/common/personal/default.nix) including gaming and note-taking | `false` |
