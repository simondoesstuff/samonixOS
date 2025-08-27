{ pkgs, lib, ... }:
{
  home.packages = [
    pkgs.vscode-extensions.vscjava.vscode-java-test
		pkgs.vscode-extensions.vscjava.vscode-java-debug
  ];

  programs.nixvim = {
    plugins.dap = {
      enable = true;

      signs.dapBreakpoint.text = "B";

      configurations = {
        java = [
          {
            type = "java";
            request = "launch";
            name = "java debug";
          }
        ];
      };
    };

    plugins.dap-ui = {
      enable = true;
    };

    # plugins.lsp.servers.jdtls = {
    # enable = true;
    # package = pkgs.jdt-language-server;
    # cmd = [ "${pkgs.jdt-language-server}/bin/jdtls" ];
    # settings.java.configuration.runtimes = [
    #   {
    #     name = "JavaSE-17";
    #     path = "${pkgs.jdk17}";
    #     default = true;
    #   }
    # ];
    # };

    # Auto sets up dap for java
    plugins.jdtls = {
      enable = true;
      settings.cmd = [
        (lib.getExe pkgs.jdt-language-server)
      ];
    };

    keymaps = [
      {
        key = "<leader>db";
        mode = "n";
        action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
        options.desc = "DAP: Toggle Breakpoint";
      }
      {
        key = "<leader>dc";
        mode = "n";
        action = "<cmd>lua require('dap').continue()<CR>";
        options.desc = "DAP: Start/Continue";
      }
      {
        key = "<leader>do";
        mode = "n";
        action = "<cmd>lua require('dap').step_over()<CR>";
        options.desc = "DAP: Step Over";
      }
      {
        key = "<leader>di";
        mode = "n";
        action = "<cmd>lua require('dap').step_into()<CR>";
        options.desc = "DAP: Step Into";
      }
      {
        key = "<leader>dO";
        mode = "n";
        action = "<cmd>lua require('dap').step_out()<CR>";
        options.desc = "DAP: Step Out";
      }
      {
        key = "<leader>du";
        mode = "n";
        action = "<cmd>lua require('dapui').toggle()<CR>";
        options.desc = "DAP: Toggle UI";
      }
    ];
  };
}
