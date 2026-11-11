{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    cups
    docker-compose
    kubectl
    kubernetes
    kubernetes-helm
    openfortivpn
    wireshark
  ];
}
