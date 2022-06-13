{
  description = "Python application using poetry and poetry2nix";

  inputs = {
    nixpkgs     = { url = "github:nixos/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };

      python = pkgs.python310;
      projectDir = ./.;
      overrides = pkgs.poetry2nix.overrides.withDefaults (final: prev: {
        # Python dependency overrides go here
      });

      packageName = "changeme";
    in {

      packages.${packageName} = pkgs.poetry2nix.mkPoetryApplication {
        inherit python projectDir overrides;
        # Other dependencies here
        propogatedBuildInputs = [];
      };

      defaultPackage = self.packages.${system}.${packageName};

      devShell = pkgs.mkShell {
        buildInputs = [
          (pkgs.poetry2nix.mkPoetryEnv {
            inherit python projectDir overrides;
          })
          pkgs.python310Packages.poetry
        ];
      };

    });
}