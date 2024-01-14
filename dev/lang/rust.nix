{ pkgs,... }:
{
	home.packages = with pkgs; [
		rust-analyzer # Rust language server
		rustc 				# Rust compiler
		cargo 				# Rust package manager
	];
}
