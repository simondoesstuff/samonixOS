# Host for the operating system class virtual machine
{root, ...}: {
  imports = [
    (root + /modules/shared/dev/git.nix)
    (root + /modules/shared/dev/nvim.nix)
    (root + /modules/shared/dev/zoxide.nix)
    ../../modules/shared/dev/language/c.nix

    (root + /modules/linux/modules.nix)
    (root + /modules/linux/zsh.nix)
  ];
}
