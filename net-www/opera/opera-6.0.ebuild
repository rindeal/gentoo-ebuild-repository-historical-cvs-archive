# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-6.0.ebuild,v 1.3 2002/05/18 17:27:52 agenkin Exp $

DESCRIPTION="Opera web browser, version 6.0 Final."
HOMEPAGE="http://www.opera.com"

NV=6.0-20020510.2-shared-qt.i386
S=${WORKDIR}/opera-${NV}
SRC_URI="http://www.panix.com/opera/files/linux/600/final/en/qt_shared/opera-${NV}.tar.bz2"

DEPEND="=x11-libs/qt-2*
	=media-libs/libpng-1.2.1*"

src_install() {

	mv install.sh install.sh_orig
	sed -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
		-e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
		-e "s:/usr/share/icons:${D}/usr/share/icons:g" \
		-e "s:/etc/X11:${D}/etc/X11:g" \
		-e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
		install.sh_orig > install.sh
	chmod 755 install.sh
	./install.sh \
		--exec_prefix=${D}/opt/opera/bin \
		--wrapperdir=${D}/opt/opera/share/bin \
		--docdir=${D}/usr/share/doc/${P} \
		--sharedir=${D}/opt/opera/share \
		--plugindir=${D}/opt/opera/share/plugins || die
	rm ${D}/usr/share/doc/${P}/help
	dosym /usr/share/opera/help /usr/share/doc/${P}/help
	dosed /usr/bin/opera

	#install the icons
	insinto /usr/share/icons /etc/X11/wmconfig /etc/X11/applnk/Internet \
		/usr/share/pixmaps /usr/share/gnome/pixmaps
	doins images/opera.xpm
	insinto /etc/X11/wmconfig 
	doins images/opera.xpm
	insinto /etc/X11/applnk/Internet 
	doins images/opera.xpm
	insinto /usr/share/pixmaps 	
	doins images/opera.xpm
	
	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/pixmaps
		doins images/opera.xpm
	fi

	insinto /etc/env.d
	doins ${FILESDIR}/10opera6
}
