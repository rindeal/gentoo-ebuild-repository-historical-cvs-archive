# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gamin/gamin-0.0.6.ebuild,v 1.1 2004/08/19 21:44:45 azarah Exp $

DESCRIPTION="Library providing the FAM File Alteration Monitor API"
HOMEPAGE="http://www.gnome.org/~veillard/gamin/"
SRC_URI="http://www.gnome.org/~veillard/gamin/sources/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=

DEPEND="virtual/libc
	>=dev-libs/glib-2.0
	!app-admin/fam"

PROVIDE="virtual/fam"

src_compile() {
	econf || die
	# Currently not smp safe
	make || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog Copyright README TODO
}
