{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix

    ../../modules/system/base.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/networking.nix
    ../../modules/system/bluetooth.nix
    ../../modules/system/ssh.nix
    ../../modules/system/terminal.nix
  ];

  users.users.beep = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "podman"
    ];
  };

  networking.firewall.allowedTCPPorts = [
    22
    8080
  ];

  systemd.services.nginx-container = {
    description = "OpenCloud in Podman";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.podman}/bin/podman run 
            --name opencloud \
            --rm \
            -d \
            -p 9200:9200 \
            -v $HOME/opencloud/opencloud-config:/etc/opencloud \
            -v $HOME/opencloud/opencloud-data:/var/lib/opencloud \
            -e OC_INSECURE=true \
            -e PROXY_HTTP_ADDR=0.0.0.0:9200 \
            -e OC_URL=https://localhost:9200 \
            opencloudeu/opencloud-rolling:latest 
      '';
      ExecStop = "${pkgs.podman}/bin/podman stop opencloud";
      Restart = "always";
      KillMode = "control-group";
    };
  };
}
