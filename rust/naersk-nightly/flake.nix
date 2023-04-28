{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, flake-utils, naersk, nixpkgs, rust-overlay }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = (import nixpkgs) {
          inherit system overlays;
        };

        naersk' = pkgs.callPackage naersk { };
        buildInputs = with pkgs; [
        ];
        nativeBuildInputs = with pkgs; [
          # This sets up the rust suite, automatically selecting the latest nightly version
          (rust-bin.selectLatestNightlyWith
            (toolchain: toolchain.default.override {
              extensions = [ "rust-src" "clippy" ];
            }))
        ];
      in
      rec {
        # For `nix build` & `nix run`:
        defaultPackage = packages.naersk-nightly;
        packages = rec {
          naersk-nightly = naersk'.buildPackage {
            src = ./.;
            nativeBuildInputs = nativeBuildInputs;
            buildInputs = buildInputs;
          };
        };

        # For `nix develop`:
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            cargo-expand
            nixpkgs-fmt
            cmake
          ] ++ buildInputs ++ nativeBuildInputs;
        };
      }
    );
}
