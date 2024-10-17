A flake that is expanding to encompass all dotfiles and system configs across linux/darwin hosts including wsl.

## Sections philosophy
- `nixos/` includes direct nixos configurations
- `hosts/` includes host setups that call modules and home-manager configurations based on the host
- `custompkgs/` includes my own custom derivations for things that aren't in nixpkgs
- `config/` includes dotfiles that are managed through nixos configuration directly

You can build a specific host with
- `sudo nixos-rebuild switch --flake .#user@hostname` for nixos configs + home-manager
- `home-manager switch --flake .#user@hostname` for just home-manager packages 

The `flake.nix` defines all of the configurations and what modules they call.
