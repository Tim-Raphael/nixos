{ pkgs, inputs, ... }:

{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/users.nix
    ../../modules/system/xserver.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/sound.nix
    ../../modules/system/printer.nix
    ../../modules/system/services.nix
    ../../modules/system/docker.nix
    ../../modules/system/terminal.nix
    ../../modules/system/printer.nix
  ];

  # Printer configuration
  hardware.printers = {
    ensurePrinters = [{
      name = "OG1-B1_MFC_L2710_sw";
      location = "OG1-B1 OpenTalk";
      deviceUri = "socket://192.168.100.209:9100";
      model = "drv:///brlaser.drv/brl2710w.ppd";
    }];
    ensureDefaultPrinter = "OG1-B1_MFC_L2710_sw";
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "raphael" = import ./home.nix; };
  };
}
