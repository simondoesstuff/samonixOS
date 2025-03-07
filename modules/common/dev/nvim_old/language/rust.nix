{
  pkgs,
  ...
}: {
    home.packages = with pkgs; [
      rustc
      cargo
      rustfmt
      rust-analyzer
      clippy
      # lldb #WARNING: I wanted to include this and use nvim-dap, but non-xcode lldb has some errors that I hope will be fixed soon. For now, I am using macos xcode LLDB in terminal myself
    ];
}
