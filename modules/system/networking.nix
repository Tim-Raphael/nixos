{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # Disable NetworkManager (iwd conflicts with it)
  networking.networkmanager.enable = false;

  # Enable iwd
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        # Enable built-in DHCP client
        EnableNetworkConfiguration = true;
        # Use systemd-resolved for DNS
        UseDefaultInterface = true;
      };

      Network = {
        EnableIPv6 = true;
        # Randomize MAC address for privacy
        # Options: "once" (per network), "always", or "disabled"
        NameResolvingService = "systemd";
      };
      Scan = {
        DisablePeriodicScan = true;
      };
    };
  };

  # Enable systemd-resolved for DNS
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
  };

  # Optional: Install impala TUI
  environment.systemPackages = with pkgs; [
    impala
    # iwctl for manual iwd control if needed
    iwd
  ];
  networking.firewall = {
    enable = true;
    # allowedUDPPorts = [ 8080 3000 ];
    # allowedTCPPorts = [ 8080 3000 ];
  };

  # Optional proxy configuration
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
