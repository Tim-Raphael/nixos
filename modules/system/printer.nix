{ pkgs, ... }:

{
  # Enable Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ ];
  };

  hardware.printers = {
    ensurePrinters = [{
      name = "OG1-B1_MFC_L2710_sw";
      location = "OG1-B1 OpenTalk";
      deviceUri = "socket://192.168.100.209:9100";
    }];
    ensureDefaultPrinter = "OG1-B1_MFC_L2710_sw";
  };

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
