{
  ...
}:

{
  imports = [
    # Vim (nixvim) is always on; VS Code is gated behind an option.
    ./nixvim
    ./vscode.nix
  ];
}
