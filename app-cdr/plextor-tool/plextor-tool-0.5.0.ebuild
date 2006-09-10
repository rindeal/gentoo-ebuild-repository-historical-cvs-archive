# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/plextor-tool/plextor-tool-0.5.0.ebuild,v 1.2 2006/09/10 08:11:53 vapier Exp $

DESCRIPTION="Tool to change the parameters of a Plextor CD-ROM drive"
HOMEPAGE="http://plextor-tool.sourceforge.net/"
SRC_URI="mirror://sourceforge/plextor-tool/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="static gnome"

DEPEND="gnome? ( gnome-base/gnome-panel )"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	sed -i \
		-e "/^CFLAGS=/s:$: ${CFLAGS}:" \
		Makefile || die "sed Makefile failed"
}

src_compile() {
	cd "${S}"/src
	local targets="plextor-tool"
	use static && targets="${targets} pt-static"
	use gnome && targets="${targets} plextor-tool-applet"
#	use static && use gnome && targets="${targets} pta-static"
	echo ${targets} > my-make-targets
	emake ${targets} || die "make ${targets} failed"
}

src_install() {
	local targets="$(<src/my-make-targets)"
	dodoc src/TODO doc/README doc/NEWS
	cd src
	dobin ${targets} || die "dobin failed"
	doman plextor-tool.8.gz
}
