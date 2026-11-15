{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    watchexec
    tealdeer

    # Docker
    docker-compose

    # Kubernetes
    kubectl
    kubernetes
    kubernetes-helm

    # Netwoking
    openfortivpn
    wireshark
  ];
}
