# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i.ebuild,v 1.2 2002/05/24 06:46:10 agenkin Exp $

DESCRIPTION="Utility for creating and opening lzh archives."
HOMEPAGE="http://www2m.biglobe.ne.jp/~dolphin/lha/lha-unix.htm"
LICENSE="lha"

DEPEND="virtual/glibc"

SRC_URI="http://www2m.biglobe.ne.jp/~dolphin/lha/prog/${P}.tar.gz"

src_unpack () {

	unpack "${A}"
	cd "${S}"
	sed -e "/^OPTIMIZE/ s/-O2/${CFLAGS}/" < Makefile > Makefile.hacked
	mv Makefile.hacked Makefile

}

src_compile () {

	emake || die
}

src_install () {

	dodir /usr/bin
	dodir /usr/share/man/ja/man1
	make BINDIR=${D}/usr/bin MANDIR=${D}/usr/share/man/ja install MANSECT=1 || die
	dodoc *.txt *.euc *.eng
}
