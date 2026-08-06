{
  ...
}:

{
  imports = [
    # Vim (nixvim) is always on; VS Code and Zed are gated behind options.
    ./nixvim
    ./vscode.nix
    ./zed.nix
  ];
}
