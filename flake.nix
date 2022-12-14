{
  description = "Cross-compilation toolchain for nix";

  outputs = { ... }:
    let
      targets = [
        "aarch64-elf"
        "arm-linux-gnueabihf"
        "i686-elf"
        "x86_64-elf"
        "x86_64-linux-gnu"
      ];
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
