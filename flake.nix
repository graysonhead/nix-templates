{
    description = "Grayson's flake templates";

    outputs = { self }: {
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
            path = ./rust/naersk
        };
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            rustc
            cargo
            clippy
            nixpkgs-fmt
            cmake
          ] ++ buildInputs ++ nativeBuildInputs;
        };
    };
}