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
			# lldb #WARNING: I wanted to include this and use nvim-dap, but non-xcode lldb has some errors that I hope will be fixed soon. For now, I am using macos xcode LLDB in terminal myself

			# (vscode-with-extensions.override {
			# 	vscodeExtensions = with vscode-extensions; [
			# 		vadimcn.vscode-lldb
			# 	];
			# })

			#INFO: Node/ts(js) lang server
			nodejs
			nodePackages_latest.typescript-language-server

			#INFO: python3
			python3
			# # Jupyter stuff
			# python311Packages.jupyter_client
			# python311Packages.pynvim
			# python311Packages.cairosvg
			# python311Packages.pnglatex
			# python311Packages.pandas
	];
}
