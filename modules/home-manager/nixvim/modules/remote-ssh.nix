{
  pkgs,
  ...
}:

let
  remote-ssh = pkgs.vimUtils.buildVimPlugin {
    pname = "remote-ssh";
    version = "0.7.0";
    src = pkgs.fetchFromGitHub {
      owner = "inhesrom";
      repo = "remote-ssh.nvim";
      rev = "b0fc5c8452b83a81bdf9bf19db3afacb26e41720";
      sha256 = "sha256-sLUZd8zBdLpZwvZAbNzsZLakhDPdgqxLUXZVGBpgLew=";
    };
    nvimRequireCheck = "remote-ssh";
  };
in
{
  programs.nixvim = {
    extraPackages = with pkgs; [
      findutils
      gnugrep
      openssh
      rsync
      python3
    ];
    extraPlugins = [ remote-ssh ];
    extraConfigLua = ''
      require("remote-ssh").setup {}
    '';
  };
}
