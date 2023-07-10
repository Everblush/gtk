{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-filter.url = "github:numtide/nix-filter";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs: let
    src = inputs.nix-filter.lib {
      root = inputs.self.outPath;
    };
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [ "aarch64-linux" "x86_64-linux" ];

      perSystem = {
        system,
        pkgs,
        ...
      }: {
        packages = {
          default = pkgs.callPackage ./default.nix { inherit src; };
        };
      };
    };
}

