{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.local.workServices.enable = lib.mkEnableOption "work host services";

  config = {
    # SSH access is restricted to named users and public keys.
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [
          "raphael"
        ]
        ++ lib.optionals config.users.remote.enable [ config.users.remote.username ];
      };
    };

    # Pods need to reach the local API server.
    networking.firewall.allowedTCPPorts = [ 6443 ];
    services.k3s = {
      enable = false;
      role = "server";
    };

    # Keep the database definition ready for manual activation.
    services.postgresql = {
      enable = false;
      package = pkgs.postgresql_17;
      ensureDatabases = [ "misc" ];
      ensureUsers = [
        {
          name = "misc";
          ensureDBOwnership = true;
        }
      ];
    };

    services.fwupd.enable = lib.mkIf config.local.workServices.enable true;

    services.openvpn.servers = lib.mkIf config.local.workServices.enable {
      officeVpnTcp.config = "config /home/raphael/.openvpn/TCP.ovpn";
      officeVpnUdp.config = "config /home/raphael/.openvpn/UDP.ovpn";
    };
  };
}
