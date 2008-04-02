# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-9999.ebuild,v 1.2 2008/04/02 03:08:37 vapier Exp $

inherit eutils

if [[ ${PV} == "9999" ]] ; then
	ECVS_SERVER="cvs.sv.gnu.org:/sources/libtool"
	ECVS_MODULE="libtool"
	inherit cvs
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"
fi

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"

LICENSE="GPL-2"
SLOT="1.5"
KEYWORDS=""
IUSE="vanilla"

RDEPEND="sys-devel/gnuconfig
	>=sys-devel/autoconf-2.60
	>=sys-devel/automake-1.10"
DEPEND="${RDEPEND}
	sys-apps/help2man"

S=${WORKDIR}/${ECVS_MODULE}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		cvs_src_unpack
		cd "${S}"
		./bootstrap || die
	else
		unpack ${A}
		cd "${S}"
	fi

	use vanilla && return 0

	epunt_cxx
	cd libltdl/m4
	epatch "${FILESDIR}"/1.5.20/${PN}-1.5.20-use-linux-version-in-fbsd.patch #109105
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	local x
	for x in libtool libtoolize ; do
		help2man ${x} > ${x}.1
		doman ${x}.1 || die
	done

	for x in $(find "${D}" -name config.guess -o -name config.sub) ; do
		rm -f "${x}" ; ln -sf /usr/share/gnuconfig/${x##*/} "${x}"
	done
}
