# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/a2ps/a2ps-4.13b-r4.ebuild,v 1.4 2002/08/16 02:42:01 murphy Exp $

S=${WORKDIR}/${P/b/}
DESCRIPTION="a2ps is an Any to PostScript filter"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${P}.tar.gz"
HOMEPAGE="http://www-inf.enst.fr/~demaille/a2ps"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"


DEPEND=">=app-text/ghostscript-6.23
	>=app-text/psutils-1.17
	tetex? ( >=app-text/tetex-1.0.7 )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"


src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	myconf="${myconf} --sysconfdir=/etc/a2ps"
	
	econf ${myconf} || die "configure failed"

	emake || die
}

src_install() { 			      

	dodir /usr/share/emacs/site-lisp

	make \
		prefix=${D}/usr \
		datadir=${D}/usr/share \
		sysconfdir=${D}/etc/a2ps \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		lispdir=${D}/usr/share/emacs/site-lisp \
		install || die

	dodoc ANNOUNCE AUTHORS ChangeLog COPYING FAQ NEWS README THANKS TODO
}
