# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.15.ebuild,v 1.2 2004/12/05 00:55:08 iggy Exp $

RESTRICT="nomirror"

DESCRIPTION="A collection of themes for the MythTV project."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/myththemes/purgalaxy/PurpleGalaxy.tar.gz
	http://www.mythtv.org/myththemes/visor/visor.tar.gz
	http://www.mythtv.org/myththemes/sleek/sleek-0.35.tar.bz2
	http://www.mythtv.org/myththemes/titivillus/Titivillus.tar.bz2
	http://www.mythtv.org/myththemes/abstract/abstract.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_install() {
	find "${WORKDIR}" -type f -print0 | xargs -0 chmod 644
	find "${WORKDIR}" -type d -print0 | xargs -0 chmod 755

	dodir /usr/share/mythtv
	cp -r "${WORKDIR}" "${D}/usr/share/mythtv/themes"
}
