
{ pkgs, ... }:

{
	home.packages = with pkgs; [
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
