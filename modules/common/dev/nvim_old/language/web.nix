{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    # tailwindcss-language-server -- better installed on a per project basis via
    # bun or npm to get proper version (tailwind 3 vs 4) based on node dep analysis

    #INFO: Node/ts(js) lang server
    nodejs
    # nodePackages_latest.typescript-language-server
    # nodePackages_latest.vscode-langservers-extracted # HTML/CSS/JSON/ESLint
    # nodePackages_latest.svelte-language-server
    nodePackages_latest.prettier
  ];
}
