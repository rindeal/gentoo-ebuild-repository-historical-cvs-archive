# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mserv/mserv-0.35.ebuild,v 1.1 2004/03/11 08:23:42 eradicator Exp $

inherit webapp-apache eutils

DESCRIPTION="Jukebox-style music server"
HOMEPAGE="http://www.mserv.org"
SRC_URI="mirror://sourceforge/mserv/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="mserv"

SLOT="0"
KEYWORDS="~x86"
IUSE="apache2 oggvorbis"

DEPEND="virtual/glibc"
RDEPEND=">=dev-lang/perl-5.6.1
	 virtual/mpg123
	 media-sound/sox
	 net-www/apache
	 oggvorbis? ( media-sound/vorbis-tools )"

S=${WORKDIR}/${P}

webapp-detect

pkg_setup() {
	enewgroup mserv > /dev/null || die
	enewuser mserv -1 /bin/false /dev/null mserv -G audio > /dev/null || die
}

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# Adjust paths to match Gentoo
	epatch ${FILESDIR}/${P}-paths.patch || die
	# Mservplay uses stricmp - should be strcasecmp
	epatch ${FILESDIR}/${P}-mservplay.patch || die
}

src_compile() {
	econf || die
	emake || die

	# Optional suid wrapper
	cd ${S}/support
	gcc -I.. -I../mserv ${CFLAGS} mservplay.c -o mservplay || die
}

src_install() {
	make DESTDIR=${D} install || die

	dobin support/mservedit support/mservripcd support/mservplay
	dodoc AUTHORS COPYING ChangeLog docs/quick-start.txt

	# Web client
	exeinto ${HTTPD_CGIBIN}/mserv
	doexe webclient/*.cgi
	insinto ${HTTPD_ROOT}/mserv
	doins webclient/*.gif webclient/index.html

	# Configuration files
	insopts -o mserv -g mserv -m0644
	insinto /etc/mserv
	fowners mserv:mserv /etc/mserv
	newins ${FILESDIR}/${P}-config config
	newins ${FILESDIR}/${P}-webacl webacl
	newins ${FILESDIR}/${P}-acl acl
	fperms 0600 /etc/mserv/acl

	exeinto /etc/init.d
	newexe ${FILESDIR}/${P}-initd ${PN}

	insinto /etc/conf.d
	newins ${FILESDIR}/${P}-confd ${PN}

	# Log file
	dodir /var/log
	touch ${D}var/log/mserv.log
	fowners mserv:mserv /var/log/mserv.log

	# Track and album info
	dodir /var/lib/mserv/trackinfo
	fowners mserv:mserv /var/lib/mserv/trackinfo
	touch ${D}/var/lib/mserv/trackinfo/.keep
	fowners mserv:mserv /var/lib/mserv/trackinfo/.keep

	# Current track output
	dodir /var/spool/mserv
	touch ${D}var/spool/mserv/player.out
	fowners mserv:mserv /var/spool/mserv /var/spool/mserv/player.out
}

pkg_postinst() {
	einfo
	einfo "The wrapper program 'mservplay' is disabled for"
	einfo "security reasons.  If you wish to use mservplay"
	einfo "to pass a 'nice' value to mpg123, you must make"
	einfo "/usr/bin/mservplay suid root."
	einfo
	einfo "The web client has been installed in"
	einfo "${HTTPD_ROOT}/mserv."
	ewarn
	ewarn "Please edit /etc/mserv/config and set path_tracks"
	ewarn "to the location of your music files."
}
