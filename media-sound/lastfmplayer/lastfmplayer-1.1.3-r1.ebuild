# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmplayer/lastfmplayer-1.1.3-r1.ebuild,v 1.2 2007/05/01 00:09:23 genone Exp $

inherit eutils versionator

DESCRIPTION="The player allows you to listen to last.fm radio streams"
HOMEPAGE="http://www.last.fm/help/player"
MY_P="${P/lastfmplayer/last.fm}"
SRC_URI="http://static.last.fm/client/Linux/${MY_P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="nomirror"
S="${WORKDIR}/${MY_P}"

DEPEND=">=x11-libs/qt-4.2
	media-libs/alsa-lib"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/13_alsa-r1.diff
}

src_compile() {
	./configure
	emake -j1 qmake_all || die "emake qmake_all failed"
	epatch ${FILESDIR}/${P}-pic.patch

	emake -j1 || die "emake failed"
}

src_install() {
	# Docs
	dodoc ChangeLog README

	# The root at which the player, data, and cache
	# are to be installed
	local destination="/opt/lastfm"
	cd bin

	# Make ${destination} writable by audio group
	diropts -m0775 -g audio
	dodir ${destination}

	# Install the player
	cp -R * ${D}/${destination}

	# Make a folder such that album art cache works
	diropts -m0775 -g audio
	dodir ${destination}/cache
	keepdir ${destination}/cache

	# Icon, menu, protcol
	make_wrapper lastfm ./last.fm ${destination} ${destination}
	newicon data/icons/as.png lastfm.png
	make_desktop_entry lastfm "Last.fm Player" lastfm.png

	insinto /usr/share/services
	doins ${FILESDIR}/lastfm.protocol
}

pkg_postinst() {
	elog "To use the Last.fm player with a mozilla based browser:"
	elog " 1. Go to about:config in the browser"
	elog " 2. Right-click on the page"
	elog " 3. Select New and then String"
	elog " 4. For the name: network.protocol-handler.app.lastfm"
	elog " 5. For the value: /usr/bin/lastfm"
	elog
	elog "If you experiance awkward fonts or widgets, try running qtconfig."
}
