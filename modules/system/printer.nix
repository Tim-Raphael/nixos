{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cups ];

  # Enable Printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ brlaser brgenml1lpr brgenml1cupswrapper ];
  };

  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
