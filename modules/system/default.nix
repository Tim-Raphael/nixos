{ pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./networking.nix
    ./packages.nix
    ./services.nix
    ./users.nix
  ];

  # Some third party binaries need the system dynamic linker.
  programs.nix-ld.enable = true;

  # The machines use Berlin time with English application messages.
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # German regional formats match the local address and measurements.
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Some desktop services look for helpers under libexec.
  environment.pathsToLink = [ "/libexec" ];

  # Native Wayland gives Electron applications the compositor scale factor.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Flakes are required to evaluate this repository.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # GRUB detects the other operating systems on these machines.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
  };

  # Zsh is the login shell for system users.
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };
  users.defaultUserShell = pkgs.zsh;

  # Desktop settings need a system Dconf service.
  programs.dconf.enable = true;

  # The Bluetooth controller should be ready after boot.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  programs.ssh.startAgent = true;

  # Desktop graphics and tablet input are needed across these machines.
  hardware.graphics.enable = true;
  hardware.opentabletdriver.enable = true;
  # OpenTabletDriver needs access to the virtual input device.
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  # Remote play and dedicated servers need their firewall ports.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # The swap file provides memory headroom on these machines.
  #swapDevices = [
  #  {
  #    device = "/var/lib/swapfile";
  #    size = 16 * 1024;
  #  }
  #];

  # Container tooling is used across these machines.
  virtualisation = {
    docker.enable = true;
    containers.enable = true;
  };

  # Packet capture requires the Wireshark system helper.
  programs.wireshark.enable = true;
}
