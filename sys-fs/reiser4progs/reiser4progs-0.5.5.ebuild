# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/reiser4progs/reiser4progs-0.5.5.ebuild,v 1.2 2004/06/25 03:18:07 agriffis Exp $

DESCRIPTION="reiser4progs: mkfs, fsck, etc..."
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="http://thebsh.namesys.com/snapshots/2004.06.14-internal.testing/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND=">=sys-libs/libaal-0.5.2"

src_compile() {
	econf --sbindir=/sbin --libdir=/lib || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /usr/lib
	mv ${D}/lib/lib{reiser4,repair}.{a,la} ${D}/usr/lib/
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO
}
