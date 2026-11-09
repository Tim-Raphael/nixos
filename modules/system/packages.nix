{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes
    kubernetes-helm
    cups
    docker-compose
    openfortivpn
    wireshark
  ];
}
