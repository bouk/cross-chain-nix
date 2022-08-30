{
  description = "Cross-compilation toolchain for nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      targets = [ "arm-linux-gnueabihf" ];
      pkgs = nixpkgs.legacyPackages.${system};
    in
      {
        packages = builtins.foldl' (a: b: a // b) {} (map (target: {
          "${target}-binutils" = pkgs.callPackage ./binutils.nix { inherit target; };
        }) targets);
      }
    );
}
