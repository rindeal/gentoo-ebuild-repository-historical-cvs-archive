# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mu-conference/mu-conference-0.6.0.ebuild,v 1.9 2004/06/24 22:57:41 agriffis Exp $

inherit eutils

DESCRIPTION="Multi-User Chat for jabberd"
HOMEPAGE="http://mu-conference.jabberstudio.org/"
SRC_URI="http://www.jabberstudio.org/files/mu-conference/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
SLOT="0"

DEPEND=">=net-im/jabberd-1.4.3
		>=dev-libs/glib-2.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/mu-conference-makefile.patch
}

src_compile() {
	emake || die
}

src_install() {
	dodir /etc/jabber /usr/lib/jabberd /var/log/jabber/conference
	keepdir /var/log/jabber/conference/

	insinto /usr/lib/jabberd
	doins src/mu-conference.so

	insinto /etc/jabber
	doins  ${FILESDIR}/muctrans.xml

	dodoc README FAQ README.jcr ${FILESDIR}/README.Gentoo

	fowners jabber:jabber /var/log/jabber/conference

	fperms g-x /var/log/jabber/conference

	fperms g+rw /var/log/jabber/conference
}

pkg_postinst() {
	einfo
	einfo "Please read /usr/share/doc/${P}/README.Gentoo.gz"
	einfo
}

