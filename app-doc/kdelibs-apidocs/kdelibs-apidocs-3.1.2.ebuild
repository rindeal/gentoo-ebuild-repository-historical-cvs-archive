# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/kdelibs-apidocs/kdelibs-apidocs-3.1.2.ebuild,v 1.6 2003/07/17 20:14:10 gmsoft Exp $

inherit kde

IUSE=""
DESCRIPTION="API documentation autogenerated from the kde-base/kdelibs package"
KEYWORDS="x86 ppc sparc alpha hppa"
HOMEPAGE="http//developer.kde.org/"
SLOT="3.1"
LICENSE="GPL-2"
SRC_URI="mirror://kde/stable/$PV/src/kdelibs-${PV}.tar.bz2"
DEPEND="app-doc/doxygen app-doc/qt-docs"
RDEPEND=""
S="${WORKDIR}/kdelibs-${PV}"


# get locations without messing with deps
set-qtdir 3
set-kdedir $PV

src_compile() {
	./configure # just give us a tolerable makefile
	make apidox
}

src_install() {
	#make DESTDIR="$D" install-apidox # doesn't install all files

	einfo "Copying files..."
	dodir ${KDEDIR}/share/doc/HTML/en/kdelibs-apidocs
	cp -r ${S}/apidocs/* ${D}/$KDEDIR/share/doc/HTML/en/kdelibs-apidocs

	#cd ${S}/apidocs
	#for x in k*; do
	#    MANDIRS="$MANDIRS:$KDEDIR/share/doc/HTML/en/kdelibs-apidocs/$x/man"
	#done
	#dodir /etc/env.d
	#echo "MANPATH=$MANDIRS" > $D/etc/env.d/80kdelibs-apidocs
}

pkg_postinst() {
	# the link from $KDEDIR/share/doc/HTML/en/kdelibs-apidocs/common
	# points to PORTAGE_TMPDIR, this fixes bug #15102
	rm $KDEDIR/share/doc/HTML/en/kdelibs-apidocs/common
	ln -sf $KDEDIR/share/doc/HTML/en/common \
	$KDEDIR/share/doc/HTML/en/kdelibs-apidocs/common
}
