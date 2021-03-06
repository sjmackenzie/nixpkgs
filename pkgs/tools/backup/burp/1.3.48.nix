{ stdenv, fetchgit, acl, librsync_0_9, ncurses, openssl, zlib }:

stdenv.mkDerivation rec {
  name = "burp-1.3.48";

  src = fetchgit {
    url = "https://github.com/grke/burp.git";
    rev = "3636ce0a992904a374234d68170fc1c265bff357";
    sha256 = "708e06b758e8f918aaf7cc8f7517a7eadd456263fe34618e32330e5ad69438c0";
  };

  patches = [ ./burp_1.3.48.patch ];

  buildInputs = [ librsync_0_9 ncurses openssl zlib ]
    # next two lines copied from bacula, as burp needs acl as well
    # acl relies on attr, which I can't get to build on darwin
    ++ stdenv.lib.optional (!stdenv.isDarwin) acl;

  configureFlags = [
      "--sbindir=$out/bin"
  ];

  meta = with stdenv.lib; {
    description = "BURP - BackUp and Restore Program";
    homepage    = http://burp.grke.org;
    license     = licenses.agpl3;
    maintainers = with maintainers; [ tokudan ];
    platforms   = platforms.all;
  };
}
