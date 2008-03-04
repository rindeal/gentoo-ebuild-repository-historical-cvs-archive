# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotes/knotes-3.5.8.ebuild,v 1.7 2008/03/04 06:36:02 jer Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Notes"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/kontact)"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal
	libkdepim libkdepim
	libkpinterfaces kontact/interfaces"
KMEXTRACTONLY="
	libkcal/
	libkdepim/
	kontact/interfaces"
KMEXTRA="kontact/plugins/knotes" # We add here the kontact's plugin instead of compiling it with kontact because it needs a lot of this programs deps.
