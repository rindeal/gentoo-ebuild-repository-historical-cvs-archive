# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/glibwww/glibwww-0.2-r2.ebuild,v 1.3 2002/07/11 06:30:26 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The Gnome WWW Libraries"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=net-libs/libwww-1.5.3-r1
	 >=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}"

src_compile() {
	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
	assert

	emake || die
}

src_install() {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc AUTHORS ChangeLog NEWS README
}
