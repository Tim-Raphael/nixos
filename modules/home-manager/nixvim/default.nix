{
  inputs,
  config,
  pkgs,
  ...
}:

{
	imports = [
		inputs.nixvim.homeManagerModules.nixvim	

      		./config/keymaps.nix
      		./config/options.nix
      		./config/plugins.nix
	];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.localmapleader = " ";
  };
}
