shell:
	nix-shell --pure -p gnumake -p gcc -p binutils -p llvm -p which -p pcre -p "pkgs.haskell.packages.ghc865Binary.ghcWithPackages (ps: with ps; [cabal-install])"

build:
	cabal new-build

run:
	cabal run
