{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  description = "Grayson's flake templates";
  outputs = { self, nixpkgs }:
    let
      pkgs = (import nixpkgs) {
        system = "x86_64-linux";
      };
    in
    {
      templates = {
        python-poetry = {
          description = "Python project with poetry, vscode, and direnv";
          path = ./python/poetry;
        };
        rust-cargo2nix = {
          description = "Rust project with cargo2nix";
          path = ./rust/cargo2nix;
        };
        rust-bevy = {
          description = "Rust and Bevy";
          path = ./rust/bevy;
        };
        rust-naersk = {
          description = "Rust Naersk";
          path = ./rust/naersk;
        };
      };
      devShell = {
        x86_64-linux = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            nixpkgs-fmt
          ];
        };
      };
    };
}
