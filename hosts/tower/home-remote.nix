{
  pkgs,
  ...
}:

{
  home = {
    stateVersion = "25.11";
    username = "remote";
    homeDirectory = "/home/remote";
  };

  imports = [
    ../../modules/home/editor
    ../../modules/home/terminal.nix
    ../../modules/home/development.nix
    ../../modules/home/agents
    ../../modules/home/direnv.nix
    ../../modules/home/theme.nix
    ../../modules/home/user-dirs.nix
    ../../modules/home/crypt.nix
  ];

  development = {
    direnv.enable = true;

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };
  };

  agents = {
    claude.enable = true;
    codex.enable = true;
    copilot.enable = true;
  };
}
