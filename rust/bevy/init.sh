#!/bin/sh

read -p "Please enter the project name (make sure it matches your folder name): " project_name
echo "====================================="
echo "Setting up git"
echo "====================================="
sed -i "s/changeme/${project_name}/g" Cargo.toml
sed -i "s/changeme/${project_name}/g" flake.nix
git init
git add * .envrc .gitignore
git reset -- init.sh
echo "====================================="
echo "Generating flake lockfile"
echo "====================================="
nix flake update
git add flake.lock Cargo.lock
git commit -m "Initial commit"
echo "====================================="
read -p "Finished bootstrapping, would you like to remove this script? y/n: " yn
case $yn in
    [Yy]* ) rm init.sh;;
esac
echo "Finished initializing project"
echo "Enter a dev shell by running 'nix develop .' from within this directory."
echo "You can run the application by running `nix run .`."
echo "If you have direnv, run 'direnv allow' to automatically set up the development environment when in this folder."
