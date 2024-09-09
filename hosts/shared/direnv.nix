{pkgs, ...}: {
  # TODO: Why does this pollute the global PATH with clang?
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  # home.packages = with pkgs; [
  # 	direnv
  # 	nix-direnv
  # ];
}
