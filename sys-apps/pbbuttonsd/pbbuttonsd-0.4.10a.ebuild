# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pbbuttonsd/pbbuttonsd-0.4.10a.ebuild,v 1.4 2002/12/09 04:37:26 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PBButtons is a PPC-only program to map special Powerbook/iBook keys in Linux"
SRC_URI="http://www.cymes.de/members/joker/projects/pbbuttons/tar/${P}.tar.gz"
HOMEPAGE="http://www.cymes.de/members/joker/projects/pbbuttons/pbbuttons.html"
KEYWORDS="ppc -x86 -sparc "
DEPEND="virtual/glibc"
RDEPEND=""
SLOT=0
LICENSE=GPL

pkg_setup() {
	if [ ${ARCH} != "ppc" ] ; then
		eerror "Sorry, this is a PPC only package."
		die "Sorry, this as a PPC only pacakge."
	fi
}

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc || die "sorry, ppc-only package"
	make || die "sorry, failed to compile pbbuttons"
}

src_install() {

	make sysconfdir=${D}/etc DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d ; newexe ${FILESDIR}/pbbuttonsd.rc5 pbbuttonsd
	dodoc README COPYING

}
