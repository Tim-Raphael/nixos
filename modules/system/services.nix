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

    services = {
      geoclue2.enable = true;
      desktopManager.gnome.enable = true;
      gnome.gcr-ssh-agent.enable = false;
      pulseaudio.enable = false;
      dbus.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    services.greetd = {
      enable = true;
      settings.default_session.command = ''
        ${pkgs.tuigreet}/bin/tuigreet \
                  --time \
                  --asterisks \
                  --user-menu \
                  --cmd "sway --unsupported-gpu"
      '';
    };

    environment.etc."greetd/environments".text = "sway\ngnome";

    # TTY settings keep boot messages away from the login screen.
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };

    # Pods need to reach the local API server.
    networking.firewall.allowedTCPPorts = [ 6443 ];
    services.k3s = {
      enable = true;
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

    services.printing = {
      enable = true;
      drivers = with pkgs; [
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
      ];
    };

    # Avahi discovers printers on the local network.
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.fwupd.enable = lib.mkIf config.local.workServices.enable true;

    services.openvpn.servers = lib.mkIf config.local.workServices.enable {
      officeVpnTcp.config = "config /home/raphael/.openvpn/TCP.ovpn";
      officeVpnUdp.config = "config /home/raphael/.openvpn/UDP.ovpn";
    };
  };
}
