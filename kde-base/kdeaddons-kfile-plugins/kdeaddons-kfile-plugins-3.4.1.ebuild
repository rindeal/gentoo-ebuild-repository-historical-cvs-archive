# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-kfile-plugins/kdeaddons-kfile-plugins-3.4.1.ebuild,v 1.3 2005/06/09 01:00:10 mr_bones_ Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kfile-plugins/"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kdeaddons kfile plugins"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc ~sparc"
IUSE=""
DEPEND="ssl? ( dev-libs/openssl )"

# kfile-cert requires ssl

