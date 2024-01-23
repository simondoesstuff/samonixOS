{ pkgs, ... }:
{
	home.packages = with pkgs; [
			lua-language-server # lua language server
			nil 								# nix language server
			javascript-typescript-langserver # JS/TS language servers

			#INFO: rust
			rust-analyzer # Rust language server
			rustc 				# Rust compiler
			cargo 				# Rust package manager
	];
}
