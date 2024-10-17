# masonixOS
A flake that is expanding to encompass all dotfiles and system configs across linux/darwin hosts including wsl.

## Philosophy
The ultimate goal is to manage the entire system with a flake, but also have the flake be agnostic to the system type. In other words, the flake should work on NixOS, MacOS/darwin, regular linux distros, and WSL (whether nixos or other).
- For NixOS based and nix-darwin, we will use the `nixos` module system to configure the system as well as home-manager for packages
- For non-nixos or nix-darwin, we will use only the `home-manager` modules to configure the system pacakges

## Sections information
- `nixos/` includes direct nixos configurations
- `hosts/` includes host setups that call modules and home-manager configurations based on the host
- `custompkgs/` includes my own custom derivations for things that aren't in nixpkgs
- `config/` includes dotfiles that are managed through nixos configuration directly

## Using the flake 
You can build a specific host with
- `sudo nixos-rebuild switch --flake .#user@hostname` for nixos configs + home-manager
- `home-manager switch --flake .#user@hostname` for just home-manager packages 

The `flake.nix` defines all of the configurations and what modules they call.
