{inputs, ...}:
with inputs;
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit nixos-wsl;};
    modules = [
      ../../nixos/wsl.nix
    ];
  }
