{
  description = "A flake for all my custom packages and flakes";

  # TODO: In the future I could maybe turn this into a public flake for others to use

  # For any external flakes, I think I will load them here and cherry-pick packages out of them.
  # For example, jerry may be like this:
  # inputs.jerryFlake.url = "github:justchokingaround/jerry";
  # outputs = {jerryFlake} : {
  # 	packages = {
  # 		jerry = jerryFlake.packages.jerry;
  # 	};
  # };
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
	};

	outputs = { self, nixpkgs, ... }:
	rec {
		pkgs = import nixpkgs { system = "x86_64-linux";};
    packages = {
      jerry = pkgs.callPackage ./jerry {withIINA = false;};
      # lobster = pkgs.callPackage ./lobster {
      #   withIINA = false;
      #   withImageSupport = false;
      # };
    };
  };
}
