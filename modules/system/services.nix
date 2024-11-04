{ config, pkgs, ... }:

{
  # Enable printing
  services.printing.enable = true;

  # Enable OpenSSH
  services.openssh.enable = true;

  # Enable Ollama service with acceleration
  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}
