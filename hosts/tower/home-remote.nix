{
  inputs,
  ...
}:

{
  home = {
    stateVersion = "25.11";
    username = "remote";
    homeDirectory = "/home/remote";
  };

  imports = [
    ../../modules/home-manager/nixvim
    ../../modules/home-manager/terminal.nix
    ../../modules/home-manager/development.nix
    ../../modules/home-manager/theme.nix
    ../../modules/home-manager/user-dirs.nix
  ];

  programs.gpg = {
    enable = true;
    settings = {
      pinentry-mode = "loopback";
    };
  };

  development = {
    tools = {
      postman.enable = true;
      dbBeaver.enable = true;
      opencode.enable = true;
    };

    versionControl = {
      git.enable = true;
      jujutsu.enable = true;
    };

    languages = {
      rust = {
        enable = true;
        lld = true;
      };
      web.enable = true;
      markdown.enable = true;
    };

    databases = {
      postgresql.enable = true;
    };
  };
}
