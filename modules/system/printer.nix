{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ cups ];

  services = {
    # Avahi discovers printers on the local network.
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
      ];
    };
  };
}
