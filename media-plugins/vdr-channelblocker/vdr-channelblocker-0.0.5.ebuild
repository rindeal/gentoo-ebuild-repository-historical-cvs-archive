# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-channelblocker/vdr-channelblocker-0.0.5.ebuild,v 1.3 2011/01/28 18:06:02 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin

DESCRIPTION="VDR plugin to manage channel list for channelblocker"
HOMEPAGE="http://www.zulu-entertainment.de/download.php?group=Plugins"
SRC_URI="http://www.zulu-entertainment.de/files/vdr-channelblocker/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0_p2[dvbsetup]"
RDEPEND="${DEPEND}"
