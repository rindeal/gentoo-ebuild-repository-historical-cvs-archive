# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.1_alpha1.ebuild,v 1.3 2002/07/25 17:53:21 danarmak Exp $
inherit kde-dist 

newdepend "opengl? ( virtual/opengl ) >=kde-base/kdebase-${PV}"

DESCRIPTION="KDE $PV - artwork"

KEYWORDS="x86"

myconf="$myconf --with-dpms"
use opengl && myconf="$myconf --with-gl" || myconf="$myconf --without-gl" 

PATCHES="$FILESDIR/xsaver-conflicting-typedefs.diff"

#
#src_install() {
#	dodir ${KDEDIR}/share/apps/kthememgr/Themes
#	kde_src_install all
#}
