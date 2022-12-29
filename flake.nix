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
    builder = hsPkgs.developPackage {
      root = ./.;
      name = "build";
    };
    
  in rec {
    packages.default = pkgs.stdenv.mkDerivation {
      name = "site";
      src = ./.;
      buildInputs = [
        builder
      ];

      buildPhase = ''
        export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive";
        export LANG=en_US.UTF-8
        site build
      '';
      
      installPhase = ''
        mkdir -p $out
        cp -r _site/* $out
      '';
      
      
    };
    devShell = pkgs.mkShell {
      buildInputs = [
        builder
        hsPkgs.haskell-language-server
        hsPkgs.hlint
        hsPkgs.fourmolu
        hsPkgs.ghcid
        hsPkgs.cabal-install
      ];
    };
  });
  
}
