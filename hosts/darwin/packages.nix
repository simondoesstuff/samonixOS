{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ollama
		cocoapods # xcode deps, need for flutter? 
	];
}
