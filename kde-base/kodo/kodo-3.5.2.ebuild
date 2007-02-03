# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kodo/kodo-3.5.2.ebuild,v 1.11 2007/02/03 10:02:20 mr_bones_ Exp $

KMNAME=kdetoys
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE: measure the desktop mileage of your mouse pointer"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="kdehiddenvisibility"
DEPEND=""
