{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    chatgpt
    cups
    docker-compose
    kubectl
    kubernetes
    kubernetes-helm
    openfortivpn
    wireshark
  ];
}
