# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate-plugins/kate-plugins-3.5.8.ebuild,v 1.7 2008/03/04 06:53:24 jer Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kate plugins and docs"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange-dual $PV $MAXKDEVER kde-base/kate)"

RDEPEND="${DEPEND}"
