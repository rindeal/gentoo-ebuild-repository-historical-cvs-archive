# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kwin-styles/kdeartwork-kwin-styles-3.4.3.ebuild,v 1.4 2005/11/24 23:25:00 cryos Exp $

KMMODULE=kwin-styles
KMNAME=kdeartwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Window styles for kde"
KEYWORDS="~alpha amd64 ~ppc ppc64 sparc ~x86"
IUSE=""
OLDDEPEND="~kde-base/kwin-$PV"
DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/kwin)"

