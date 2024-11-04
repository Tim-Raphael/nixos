{ pkgs, ... }:

{
  home.packages = with pkgs; [ docker vmware-workstation ];
}
