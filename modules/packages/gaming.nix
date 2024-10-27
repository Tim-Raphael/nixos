{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ steam minecraft prismlauncher ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
