# Host for the operating system class virtual machine
{root, ...}:
{
  imports = [
		(root + /packages/shared/dev/git.nix)
		(root + /packages/shared/dev/nvim.nix)
		(root + /packages/shared/dev/zoxide.nix)
		../../packages/shared/dev/language/c.nix

		(root + /packages/linux/packages.nix)
		(root + /packages/linux/zsh.nix)
  ];
}
