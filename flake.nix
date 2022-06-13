{
    description = "Grayson's flake templates";

    outputs = { self }: {
        python-poetry = {
            description = "Python project with poetry, vscode, and direnv";
            path = ./python/poetry;
        };
    }
}