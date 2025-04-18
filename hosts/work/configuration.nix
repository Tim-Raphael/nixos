{
  pkgs,
  inputs,
  nix-colors,
  ...
}:

{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  imports = [
    ./hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/dconf.nix
    ../../modules/system/users.nix
    ../../modules/system/security.nix
    ../../modules/system/keyboard.nix
    ../../modules/system/sound.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/terminal.nix
    ../../modules/system/printer.nix
    ../../modules/system/ssh.nix
    ../../modules/system/greetd.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  # Printer configuration
  hardware.printers = {
    ensurePrinters = [
      {
        name = "OG1-B1_MFC_L2710_sw";
        location = "OG1-B1 OpenTalk";
        deviceUri = "socket://192.168.100.209:9100";
        model = "drv:///brlaser.drv/brl2710w.ppd";
      }
    ];
    ensureDefaultPrinter = "OG1-B1_MFC_L2710_sw";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit nix-colors;
    };
    users = {
      "raphael" = import ./home.nix;
    };
  };
}
