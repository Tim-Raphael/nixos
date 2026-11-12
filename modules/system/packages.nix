{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

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
