# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-femon/vdr-femon-1.1.0.ebuild,v 1.2 2006/10/30 14:05:43 zzam Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: DVB Frontend Status Monitor (signal strengt/noise)"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/femon/"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/femon/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.3.44"
