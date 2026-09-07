{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "raphael";
    group = "users";
    dataDir = "/home/raphael/.local/share/syncthing";

    # GUI stays on localhost; reach it via `ssh -L 8384:localhost:8384`.
    guiAddress = "127.0.0.1:8384";

    # Opens 22000 tcp/udp + 21027 udp so paired devices can actually connect.
    openDefaultPorts = true;

    # Devices are paired and folders are shared with them through the GUI,
    # since we don't have device IDs yet. Overriding either would wipe that
    # pairing/sharing back out on every rebuild or service restart.
    overrideDevices = false;
    overrideFolders = false;

    settings.folders."notes" = {
      id = "notes";
      label = "Notes";
      path = "/home/raphael/wksp/gh/notes/main";
      devices = [ ];
    };
  };

  # systemd already auto-starts (wantedBy multi-user.target) and
  # auto-restarts (Restart=on-failure) the syncthing.service unit.
}
