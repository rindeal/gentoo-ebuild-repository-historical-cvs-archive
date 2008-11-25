# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bless/bless-0.6.0.ebuild,v 1.1 2008/11/25 16:49:56 loki_val Exp $

EAPI=2

inherit autotools eutils gnome2 mono

DESCRIPTION="GTK# Hex Editor"
HOMEPAGE="http://home.gna.org/bless/"
SRC_URI="http://download.gna.org/bless/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-lang/mono-1.1.14
		>=dev-dotnet/gtk-sharp-2.8
		|| ( >=dev-dotnet/gtk-sharp-2.12.6[glade] >=dev-dotnet/glade-sharp-2.8 )"
DEPEND="${RDEPEND}
		  app-text/scrollkeeper
		>=sys-devel/gettext-0.15
		>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} --enable-unix-specific $(use_enable debug)"

	# Stolen from enlightenment.eclass
	cp $(type -p gettextize) "${T}/" || die "Could not copy gettextize"
	sed -i -e 's:read dummy < /dev/tty::' "${T}/gettextize"
}

src_unpack() {
	gnome2_src_unpack

	einfo "Running gettextize -f --no-changelog..."
	( "${T}/gettextize" -f --no-changelog > /dev/null ) || die "gettexize failed"
	eautoreconf
}

src_configure() {
	gnome2_src_configure
}

src_compile() {
	default
}
