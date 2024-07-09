{ pkgs, ... }:

{
	home.packages = with pkgs; [
			lua-language-server # lua language server
			nixd # nix language server but better
			vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			tailwindcss-language-server # Tailwind CSS

			#INFO: Node/ts(js) lang server
			nodejs
			nodePackages_latest.typescript-language-server
			# nodePackages_latest.vscode-langservers-extracted # HTML/CSS/JSON/ESLint
			nodePackages_latest.svelte-language-server
      nodePackages_latest.prettier
	];
}
