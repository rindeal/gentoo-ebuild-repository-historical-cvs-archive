# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/ttmkfdir/ttmkfdir-0.0.ebuild,v 1.1 2001/03/11 22:13:01 pete Exp $

#P=
A=ttmkfdir.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="a utility to create a fonts.scale file from a set of TrueType fonts"
SRC_URI="http://www.joerg-pommnitz.de/TrueType/ttmkfdir.tar.gz"
HOMEPAGE="http://www.joerg-pommnitz.de/TrueType/xfsft.html"

DEPEND=">=media-libs/freetype-1.1
	<media-libs/freetype-2.0"

src_unpack() {
    mkdir ${P}
    cd ${P}
    unpack ${A}
    patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try make clean
    try make OPT=\""${CFLAGS}"\"
}

src_install () {
    try make DESTDIR=${D} install
    dodoc README
}
