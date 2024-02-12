{ pkgs, ... }:
{
	home.packages = with pkgs; [
			lua-language-server # lua language server
			nil 								# nix language server
			vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			tailwindcss-language-server # Tailwind CSS

			#INFO: rust
			rustc
			cargo
			rustfmt
			rust-analyzer
			clippy
			lldb

			#INFO: Node/ts(js) lang server
			nodejs
			nodePackages_latest.typescript-language-server

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
