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
    };
}