{
  description = "Cross-compilation toolchain for nix";

  outputs = { ... }:
    let
      targets = [ "arm-linux-gnueabihf" ];
    in
      {
        overlay = (_: super: 
          builtins.listToAttrs (map (target: {
            name = "${target}-binutils";
            value = super.callPackage ./binutils.nix { inherit target; };
          }) targets)
        );
      };
}
