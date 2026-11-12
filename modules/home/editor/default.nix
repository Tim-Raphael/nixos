{
  ...
}:

{
  imports = [
    ./nixvim
  ];

  programs = {
    vscode.enable = true;
    helix.enable = true;
  };
}
