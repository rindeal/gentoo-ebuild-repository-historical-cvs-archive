# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/caps-plugins/caps-plugins-0.2.1-r1.ebuild,v 1.2 2005/05/25 16:05:59 luckyduck Exp $

inherit eutils

IUSE=""
MY_P=caps-${PV}

DESCRIPTION="The CAPS Audio Plugin Suite - LADSPA plugins"
HOMEPAGE="http://quitte.de/dsp/caps.html"
SRC_URI="http://quitte.de/dsp/caps_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.1.10-fpic.patch || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dodoc AUTHORS README
	dohtml caps.html
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
