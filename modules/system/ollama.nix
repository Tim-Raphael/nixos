{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ollama ];

  services.ollama = {
    enable = true;
    acceleration = "rocm";
  };
}
