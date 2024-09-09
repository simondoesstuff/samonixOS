{pkgs, ...}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
        black # formatter
        isort # import sorter
        pyright # lang server for type checking
        python-lsp-server # other lang server
        matplotlib
        numpy
      ]))
  ];

  programs.poetry = {
    enable = true;
  };
}
