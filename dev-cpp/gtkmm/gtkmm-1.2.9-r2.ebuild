# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkmm/gtkmm-1.2.9-r2.ebuild,v 1.3 2003/08/01 20:49:12 vapier Exp $

DESCRIPTION="C++ interface for GTK+"
SRC_URI="http://download.sourceforge.net/gtkmm/${P}.tar.gz"
#	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz
#	 http://ftp.gnome.org/pub/GNOME/stable/sources/gtk+/${P}.tar.gz"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="GPL-2"
SLOT="1.2"
KEYWORDS="x86 ppc sparc hppa"
IUSE="debug"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/libsigc++-1.0*"

src_unpack() {
	unpack ${A}

	# this patch applies only to gtkmm-1.2.9. gtkmm has been fixed
	# in CVS. It fixes a build problem with gcc3.1.
	# (http://marc.theaimsgroup.com/?l=gtkmm&m=101879848701486&w=2)
	patch -p0 <${FILESDIR}/gtkmm-1.2.9-gcc3.1-gentoo.patch
}

src_compile() {
	local myconf
	[ `use debug` ] \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	econf \
		--sysconfdir=/etc/X11 \
		--with-xinput=xfree \
		--with-x \
		${myconf} || die
		
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
