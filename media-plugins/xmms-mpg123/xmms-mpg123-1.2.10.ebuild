# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-mpg123/xmms-mpg123-1.2.10.ebuild,v 1.3 2005/02/28 10:53:10 eradicator Exp $

IUSE="ipv6"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc x86"

DEPEND=">=media-sound/xmms-1.2.10"

PLUGIN_PATH="Input/mpg123"

M4_VER="1.0"

inherit xmms-plugin

src_compile() {
	myconf="${myconf} --enable-mpg123 $(use_enable ipv6)"
	xmms-plugin_src_compile
}
