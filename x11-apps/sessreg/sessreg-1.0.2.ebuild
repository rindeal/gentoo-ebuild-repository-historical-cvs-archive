# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/sessreg/sessreg-1.0.2.ebuild,v 1.10 2007/06/18 01:06:26 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="manage utmp/wtmp entries for non-init clients"

KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
	x11-libs/libX11
	x11-proto/xproto"

PATCHES="${FILESDIR}/${P}-fbsd.patch"
