# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cm/cm-2.4.2.ebuild,v 1.3 2004/03/23 06:40:07 eradicator Exp $

DESCRIPTION="Common Music: An object oriented music composition environment in LISP/scheme"
HOMEPAGE="http://commonmusic.sourceforge.net"
SRC_URI="mirror://sourceforge/commonmusic/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-util/guile-1.6.4"

src_install() {
	dodir /usr/share/${PN}
	# the installer part needs the bin dir created
	keepdir /usr/share/${PN}/bin
	dodir /usr/share/${PN}/src
	insinto /usr/share/${PN}/src
	doins ${S}/src/*
	insinto /usr/share/${PN}/src/plotter
	doins ${S}/src/plotter/*
	dodir /usr/share/${PN}/etc
	insinto /usr/share/${PN}/etc
	doins ${S}/etc/*
	dodir /usr/share/${PN}/contrib
	insinto /usr/share/${PN}/contrib
	doins ${S}/etc/contrib/*
	dodir /usr/share/${PN}/examples
	insinto /usr/share/${PN}/examples
	doins ${S}/etc/examples/*
	dohtml -r doc/*
	dodoc ${S}/readme.text ${S}/doc/changelog.text
}

pkg_postinst() {
	# when the package is first run it generates the cm script
	# that will load the necessary source files into guile when run
	guile -c "(load \"/usr/share/cm/src/cm.scm\")"
	ln /usr/share/cm/bin/cm /usr/bin/cm
	chmod +x /usr/bin/cm
}

#This will break upgrades
#pkg_prerm() {
#	if [ -e /usr/bin/cm ]; then
#	    rm /usr/bin/cm
#	fi
#	if [ -e /usr/share/cm/bin ]; then
#		rm -rf /usr/share/cm/bin
#	fi
#}
