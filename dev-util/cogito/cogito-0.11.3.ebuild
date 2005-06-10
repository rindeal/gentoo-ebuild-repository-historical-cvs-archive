# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cogito/cogito-0.11.3.ebuild,v 1.1 2005/06/10 17:43:45 r3pek Exp $

inherit eutils

DESCRIPTION="The GIT scripted toolkit"
HOMEPAGE="http://kernel.org/pub/software/scm/cogito/"
SRC_URI="http://kernel.org/pub/software/scm/cogito/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="mozsha1 ppcsha1 doc"

DEPEND="dev-libs/openssl
	sys-libs/zlib
	!dev-util/git
	doc? ( app-text/asciidoc app-text/xmlto )"

RDEPEND="net-misc/rsync
		app-text/rcs
		net-misc/curl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/^CFLAGS/s:-g -O2:${CFLAGS}:" \
		-e "/^prefix?/s:\$(HOME):/usr:" \
		Makefile || die "sed failed"
}

src_compile() {
	if use mozsha1 ; then
		export MOZILLA_SHA1=yes
	elif use ppcsha1 ; then
		export PPC_SHA1=yes
	fi

	emake || die "emake failed"

	if use doc; then
		cd ${S}/Documentation
		make || die "make documentation failed"
	fi
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc README*
	doman Documentation/*.1 Documentation/*.7
}
