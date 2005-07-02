# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-3.4.1-r1.ebuild,v 1.4 2005/07/02 01:20:45 pylon Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE System Guard"
KEYWORDS="amd64 ppc ppc64 ~sparc x86"
IUSE="lm_sensors"
DEPEND="lm_sensors? ( sys-apps/lm_sensors )"

PATCHES="${FILESDIR}/kdebase-3.4.1-configure.patch"

src_compile() {
	myconf="$myconf `use_with lm_sensors sensors`"
	kde-meta_src_compile
}
