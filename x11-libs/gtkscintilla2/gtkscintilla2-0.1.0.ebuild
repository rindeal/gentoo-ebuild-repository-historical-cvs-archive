# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkscintilla2/gtkscintilla2-0.1.0.ebuild,v 1.6 2004/10/17 18:05:36 liquidx Exp $

MY_P="GtkScintilla2-${PV}"
DESCRIPTION="Gtk-2 wrappers for the Scintilla source editing components."
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://gphpedit.org/download/files/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86 ~amd64 ppc"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.0"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-lang/python-2.2
	${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {

	unpack ${A}
	cd ${S}

	# some quick touches to the Makefile, bump the version
	# and make use of our CFLAGS
	GTHREAD_LDFLAGS="$(pkg-config gthread-2.0 --libs)"
	sed -e "/CFLAGS/s/-g/${CFLAGS} -fPIC/" \
		-e "s/^LDFLAGS_PRE =/LDFLAGS_PRE = ${GTHREAD_LDFLAGS}/" \
		-i Makefile

	# and again, in the scintilla part
	cd ${S}/scintilla/gtk
	sed -e "/CXXFLAGS/s/-Os/${CFLAGS} -fPIC/" -i makefile

}

src_compile() {
	emake  || die
}

src_install() {

	make DESTDIR=${D} install || die
	dodoc COPYING README

}
