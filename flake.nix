{
  description = "Website test";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: with inputs;
  flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs { inherit system; };
    hsPkgs = pkgs.haskellPackages;
  in rec {
    packages.default = hsPkgs.developPackage {
      name = "test";
      root = ./.;
    };
  }); 
}