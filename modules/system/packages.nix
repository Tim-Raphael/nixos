{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Version Control
    git
    git-lfs
    glab
    github-cli

    # Terminal
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
