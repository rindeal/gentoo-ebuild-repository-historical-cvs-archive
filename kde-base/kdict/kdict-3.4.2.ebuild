# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdict/kdict-3.4.2.ebuild,v 1.10 2006/03/27 14:00:07 agriffis Exp $

KMNAME=kdenetwork
MAXKDEVER=3.4.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE dict client (for dict.org-like servers)"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""
