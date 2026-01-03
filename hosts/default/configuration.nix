{
  pkgs,
  inputs,
  ...
}:

{
  # Pin the state version here.
  #system.stateVerion = "xx.xx";
  imports = [
    # When setting up a new system, copy over this file and adjust the path.
    /etc/nixos/hardware-configuration.nix
    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/media.nix
    ../../modules/system/dconf.nix
    ../../modules/system/ssh.nix
    ../../modules/system/terminal.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit pkgs;
    };
    users = {
      "raphael" = import ./home.nix;
    };
  };
}
