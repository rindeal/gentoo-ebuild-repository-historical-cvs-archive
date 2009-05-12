# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capisuite/capisuite-0.4.5-r6.ebuild,v 1.1 2009/05/12 18:01:29 ssuominen Exp $

inherit eutils autotools flag-o-matic multilib python

DESCRIPTION="ISDN telecommunication suite providing fax and voice services"
HOMEPAGE="http://www.capisuite.de"
SRC_URI="http://www.capisuite.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/python
	media-sound/sox
	>=media-libs/tiff-3.7.1
	media-gfx/jpeg2ps
	media-gfx/sfftobmp
	virtual/ghostscript
	net-dialup/capi4k-utils"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-as-needed.patch"

	# taken from capisuite-0.4.5-5.src.rpm (SuSE-9.3)
	epatch "${FILESDIR}/${P}-capi4linux_v3.diff"

	# patched scripts/cs_helpers.pyin (bug #96540)
	epatch "${FILESDIR}/${P}-date-header.patch"

	# patched src/backend/connection.cpp (bug #69522)
	epatch "${FILESDIR}/${PN}-fax-compatibility.patch"

	# patched scripts/{incoming,idle}.py (bug #147854)
	epatch "${FILESDIR}/${P}-syntax.patch"

	# GCC 4.3 patches (bug #236777)
	epatch "${FILESDIR}/${P}-gcc43.patch"

	# Python 2.5 patches (bug #232734)
	epatch "${FILESDIR}/${P}-python25.patch"

	# Compability with current SOX (bug #250320)
	epatch "${FILESDIR}/${P}-sox.patch"

	# run autotools
	eautoreconf
}

src_compile() {
	strip-flags  # see bug #90901

	econf --localstatedir=/var \
		--with-docdir="/usr/share/doc/${PF}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed."

	rm -f "${D}"/usr/{lib,share}/capisuite/README
	rmdir -p --ignore-fail-on-non-empty "${D}/var/log"
	rm -f "${D}/usr/share/doc/${PF}"/{COPYING,manual.pdf}
	keepdir /var/spool/capisuite/{done,failed,sendq,users}

	dodir /etc/init.d
	newinitd "${FILESDIR}/capisuite.initd" capisuite

	insinto /etc/logrotate.d
	newins "${FILESDIR}/capisuite.logrotated" capisuite

	dodoc AUTHORS ChangeLog NEWS README TODO

	exeinto /etc/cron.daily
	doexe capisuite.cron

	insinto /etc/capisuite
	doins cronjob.conf
}

pkg_postinst() {
	python_version
	python_mod_compile /usr/$(get_libdir)/python${PYVER}/site-packages/cs_helpers.py
}

pkg_postrm() {
	python_mod_cleanup
}
