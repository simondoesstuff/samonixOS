{ pkgs, ... }:

let
	#https://github.com/nolanderc/glsl_analyzer/releases/download/v1.4.4/aarch64-macos.zip
  version = "1.4.4";
  url = "https://github.com/nolanderc/glsl_analyzer/releases/download/v${version}/aarch64-macos.zip";

	glslanalyzer = pkgs.stdenv.mkDerivation {
		pname = "glslanalyzer";
		version = "1.4.4";

		src = pkgs.fetchzip {
			url = "https://github.com/nolanderc/glsl_analyzer/releases/download/v${version}/aarch64-macos.zip";
			sha256 = "1p1crnfbfa9jl96p8m44mpa7fw2n0bdabp67vhmy74a3j26dnl3f";
		};

		installPhase = ''
			mkdir -p $out/bin
			cp -r $src/* $out/bin
		'';
	};
in
{
	home.packages = with pkgs; [
			lua-language-server # lua language server
			# nil 								# nix language server
			nixd
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

			# GLSL
			glslanalyzer
			# glslls # language server not mac?
			# glslviewer # live renderer

			#INFO: Node/ts(js) lang server
			nodejs
			nodePackages_latest.typescript-language-server
			nodePackages_latest.svelte-language-server

			#INFO: python3
			python3
			# (pkgs.python3.withPackages (python-pkgs: [
			# 	python-pkgs.mov-cli
			# ]))
			# # Jupyter stuff
			# python311Packages.jupyter_client
			# python311Packages.pynvim
			# python311Packages.cairosvg
			# python311Packages.pnglatex
			# python311Packages.pandas
	];
}
