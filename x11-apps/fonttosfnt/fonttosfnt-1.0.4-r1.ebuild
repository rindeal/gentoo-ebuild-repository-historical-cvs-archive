# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fonttosfnt/fonttosfnt-1.0.4-r1.ebuild,v 1.2 2012/06/22 20:20:54 ago Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="X.Org fonttosfnt application"
KEYWORDS="amd64 ~arm ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""
RDEPEND="x11-libs/libX11
	=media-libs/freetype-2*
	x11-libs/libfontenc"
DEPEND="${RDEPEND}"
