# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.6.99.ebuild,v 1.3 2004/07/11 06:36:31 lv Exp $


DESCRIPTION="ebuild for redirecting old linux-headers-2.6 users to the new linux26-headers"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm amd64"

PDEPEND="sys-kernel/linux26-headers"

src_compile() {
	ewarn "the 2.6 headers have moved to linux26-headers"
}

