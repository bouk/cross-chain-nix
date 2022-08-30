{ target, stdenv, lib, fetchurl, texinfo, zlib, gettext, bison, perl, makeWrapper, keybase }:

# Inspired by https://github.com/Homebrew/homebrew-core/blob/8f4d5f1aec2ccd9818631b84f474e8036a203507/Formula/arm-linux-gnueabihf-binutils.rb
# https://github.com/Homebrew/homebrew-core/blob/fc4b38101b880e84c3d695386f4acda6e0d583f2/Formula/aarch64-elf-binutils.rb
# https://github.com/Homebrew/homebrew-core/blob/fc4b38101b880e84c3d695386f4acda6e0d583f2/Formula/x86_64-elf-binutils.rb
# https://github.com/Homebrew/homebrew-core/blob/fc4b38101b880e84c3d695386f4acda6e0d583f2/Formula/x86_64-linux-gnu-binutils.rb

stdenv.mkDerivation rec {
  pname = "${target}-binutils";
  version = "2.39";

  src = fetchurl {
    url = "https://ftp.gnu.org/gnu/binutils/binutils-2.39.tar.xz";
    sha256 = "sha256-ZFwl9WO4rcCoHb1qQc/79NNwg6OC4C1dPfT2XAlRbQA=";
  };

  configureFlags = [
    "--disable-debug"
    "--disable-dependency-tracking"
    "--disable-nls"
    "--disable-werror"
    "--enable-deterministic-archives"
    "--enable-gold=yes"
    "--enable-interwork"
    "--enable-ld=yes"
    "--infodir=$(out)/share/info/${target}"
    "--libdir=$(out)/lib/${target}"
    "--target=${target}"
    "--with-system-zlib"
  ];

  nativeBuildInputs = [ bison perl texinfo ];
  buildInputs = [ zlib gettext ];

  meta = {
    description = "Cross-compiled binutils";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = [ lib.maintainers.bouk ];
  };
}
