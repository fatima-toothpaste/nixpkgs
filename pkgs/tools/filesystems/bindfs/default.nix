{ lib, stdenv, fetchurl, fuse, fuse3, pkg-config }:

stdenv.mkDerivation rec {
  version = "1.17.4";
  pname = "bindfs";

  src = fetchurl {
    url    = "https://bindfs.org/downloads/${pname}-${version}.tar.gz";
    sha256 = "sha256-b9Svm6LsK9tgPvjuoqnRLbLl/py+UrhkC0FXNKWfPcw=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = if stdenv.isDarwin then [ fuse ] else [ fuse3 ];
  postFixup = ''
    ln -s $out/bin/bindfs $out/bin/mount.fuse.bindfs
  '';

  meta = {
    description = "A FUSE filesystem for mounting a directory to another location";
    homepage    = "https://bindfs.org";
    license     = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ lovek323 lovesegfault ];
    platforms   = lib.platforms.unix;
  };
}
