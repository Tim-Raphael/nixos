{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal
    glab
    just
    tealdeer
    watchexec

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
