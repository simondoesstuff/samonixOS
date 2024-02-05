{ pkgs, ... }:
{
	home.packages = with pkgs; [
			lua-language-server # lua language server
			nil 								# nix language server
			javascript-typescript-langserver # JS/TS
			vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			tailwindcss-language-server # Tailwind CSS
			# gcc # C compiler
		

			#INFO: rust
			rustc
			cargo
			rustfmt
			rust-analyzer
			clippy


			#INFO: python3
			# python3
			# # Jupyter stuff
			# python311Packages.jupyter_client
			# python311Packages.pynvim
			# python311Packages.cairosvg
			# python311Packages.pnglatex
			# python311Packages.pandas
	];
}
