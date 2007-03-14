# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xfc/xfc-4.3.1.ebuild,v 1.1 2007/03/14 14:58:07 drac Exp $

DESCRIPTION="C++ bindings to Xfce desktop environment"
HOMEPAGE="http://xfc.xfce.org"
SRC_URI="http://xfc.xfce.org/download/${PV}/src/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc debug examples"

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/libsigc++-2.0.6
	>=dev-libs/atk-1.9
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.6
	>=gnome-base/libglade-2.4
	dev-lang/perl
	doc? ( >=app-doc/doxygen-1.3.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable doc docs) \
		$(use_enable debug) \
		$(use_enable debug tests) \
		$(use_enable examples) \
		$(use_enable examples demos)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
