# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/lisa/lisa-3.5.8.ebuild,v 1.8 2008/02/19 04:43:36 ingmar Exp $

KMNAME=kdenetwork
KMMODULE=lanbrowsing
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"

inherit kde-meta

SRC_URI="${SRC_URI}
	mirror://gentoo/kdenetwork-3.5-patchset-01.tar.bz2"

DESCRIPTION="KDE Lan Information Server - allows KDE desktops to share information over a network."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
KMEXTRA="doc/kcontrol/lanbrowser"

src_install() {
	kde-meta_src_install

	chmod u+s "${D}/${KDEDIR}/bin/reslisa"

	# lisa, reslisa initscripts
	sed -e "s:_KDEDIR_:${KDEDIR}:g" "${WORKDIR}/patches/lisa" > "${T}/lisa"
	sed -e "s:_KDEDIR_:${KDEDIR}:g" "${WORKDIR}/patches/reslisa" > "${T}/reslisa"
	doinitd "${T}/lisa" "${T}/reslisa"

	newconfd "${WORKDIR}/patches/lisa.conf" lisa
	newconfd "${FILESDIR}/reslisa.conf" reslisa

	for x in /etc/lisarc /etc/reslisarc; do
		echo '# Default lisa/reslisa configfile' > "${D}"/$x
	done
}
