# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-21.5.ebuild,v 1.1 2005/01/01 22:07:33 vapier Exp $

inherit eutils

SELINUX_PATCH="${P}-selinux.diff.bz2"

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls selinux"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use selinux && epatch ${FILESDIR}/${SELINUX_PATCH}
	epunt_cxx #73632
}

src_compile() {
	local myconf=""
	use selinux && myconf="${myconf} --enable-flask"
	econf \
		--bindir=/bin \
		$(use_enable nls) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die

	# Some packages expect these to use /usr, others to use /
	dodir /usr/bin
	cd "${D}"/bin
	for f in * ; do
		dosym /bin/${f} /usr/bin/${f}
	done

	dodoc AUTHORS ChangeLog NEWS README
}
