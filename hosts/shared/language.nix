{ pkgs, ... }:

let
	version = "1.4.4";
	glslanalyzer = pkgs.stdenv.mkDerivation {
		pname = "glslanalyzer";
		version = version;

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
			nixd # nix language server but better
			vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			tailwindcss-language-server # Tailwind CSS

			#INFO: rust
			rustc
			cargo
			rustfmt
			rust-analyzer
			clippy
			# lldb #WARNING: I wanted to include this and use nvim-dap, but non-xcode lldb has some errors that I hope will be fixed soon. For now, I am using macos xcode LLDB in terminal myself

			#INFO: GLSL
			glslanalyzer

			#INFO: Node/ts(js) lang server
			nodejs
			nodePackages_latest.typescript-language-server
			# nodePackages_latest.vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			nodePackages_latest.svelte-language-server
      nodePackages_latest.prettier

			#INFO: python3
			(python3.withPackages (ps: with ps; [
				black # formatter
				isort # import sorter
				pyright # lang server for type checking
				matplotlib
				python-lsp-server
			]))
	];
}
