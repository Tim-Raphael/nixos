{ lib, pkgs, ... }:

{
  # Experiment
  home.packages = with pkgs; [
    opencode
    bun
  ];

  #home.file.".config/opencode/opencode.json".text = ''
  #  {
  #    "$schema": "https://opencode.ai/config.json",
  #    "provider": {
  #      "ollama": {
  #        "npm": "@ai-sdk/openai-compatible",
  #        "options": {
  #          "baseURL": "http://localhost:11434/v1"
  #        },
  #        "models": {
  #          "qwen3:8b-16k": {
  #            "tools": true
  #          },
  #          "qwen2.5-coder:3b-16k": {
  #            "tools": true
  #          }
  #        }
  #      }
  #    }
  #  }
  #'';

  services.ollama = {
    enable = true;
  };
}
