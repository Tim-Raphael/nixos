{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cups ];

  # Enable Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ brlaser brgenml1lpr brgenml1cupswrapper ];
  };

  hardware.printers = {
    ensurePrinters = [{
      name = "OG1-B1_MFC_L2710_sw";
      location = "OG1-B1 OpenTalk";
      deviceUri = "socket://192.168.100.209:9100";
      model = "drv:///brlaser.drv/brl2710w.ppd";
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
