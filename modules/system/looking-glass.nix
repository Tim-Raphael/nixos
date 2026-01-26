{
  pkgs,
  ...
}:

{

  # Add self to the libvirtd user group
  users.groups.libvirtd.members = [ "raphael" ];

  environment.systemPackages = with pkgs; [
    # Required for DNS and DHCP functionallity
    dnsmasq

    virt-manager
    virt-viewer

    spice
    spice-gtk
    spice-protocol

    virtio-win
    win-spice
    adwaita-icon-theme
  ];

  virtualisation = {
    # Activate libvirtd (common API for virtualisation backend)
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
    # Enable USB redirection
    spiceUSBRedirection.enable = true;
  };

  services.spice-vdagentd.enable = true;

  # Whitelist intferface for the firewall
  networking.firewall.trustedInterfaces = [ "virbr0" ];

  # Kernel modules for PCI passthrough
  boot.initrd.kernelModules = [
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
    # Replace or remove with your devices driver as needed
    "amdgpu"
    "amd_iommu=on"
  ];
}
