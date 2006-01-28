# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/telnet-bsd/telnet-bsd-1.0-r1.ebuild,v 1.3 2006/01/28 13:42:17 blubb Exp $

inherit eutils

DESCRIPTION="Telnet and telnetd ported from OpenBSD with IPv6 support"
HOMEPAGE="ftp://ftp.suse.com/pub/people/kukuk/ipv6/"
SRC_URI="ftp://ftp.suse.com/pub/people/kukuk/ipv6/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="nls"

DEPEND="!net-misc/netkit-telnetd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/telnet-bsd_gentoo.diff
	epatch "${FILESDIR}"/${P}-overflow.patch #87019
	sed -i \
		-e 's:destdir=:destdir=$(DESTDIR):' \
		po/Makefile.in.in \
		|| die "sed failed"
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	insinto /etc/xinetd.d
	newins "${FILESDIR}"/telnetd.xinetd telnetd
	dodoc README THANKS NEWS AUTHORS ChangeLog INSTALL
}
