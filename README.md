# nix-templates


This is a collection of Flake templates I commonly use to set up software envrionments, you can use them like so:

## Python Poetry
```
nix flake new --template github:graysonhead/nix-templates#python-poetry ./project-folder
```

## Rust Cargo2nix

```
nix flake new --template github:graysonhead/nix-templates#rust-cargo2nix ./project-folder
cd project-folder
chmod +x init.sh && ./init.sh
```

Feel free to use and modify them for work or personal projects. This repo is MIT licensed.