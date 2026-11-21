{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    watchexec
    tealdeer
    just

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
