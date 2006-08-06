# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/ipkg-utils/ipkg-utils-1.7.050831.ebuild,v 1.2 2006/08/06 14:44:34 seemant Exp $

inherit distutils eutils toolchain-funcs versionator

MY_P=${PN}-$(get_version_component_range 3)

DESCRIPTION="Tools for working with the ipkg binary package format"
HOMEPAGE="http://www.openembedded.org/"
SRC_URI="http://handhelds.org/download/packages/ipkg-utils/${MY_P}.tar.gz"
LICENSE="GPL-2"
IUSE="minimal"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~mips ~ppc ~x86"
S=${WORKDIR}/${MY_P}

RDEPEND="dev-lang/python
	!minimal? (
		app-crypt/gnupg
		net-misc/curl
	)"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}; cd ${S}

	sed '/python setup.py build/d' -i Makefile

	if use minimal; then
		einfo "ipkg-upload is not installed when the \`minimal' USE flag is set.  If you"
		einfo "need ipkg-upload then rebuild this package without the \`minimal' USE flag."
	fi
}

src_compile() {
	distutils_src_compile
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	distutils_src_install
	use minimal && rm ${D}/usr/bin/ipkg-upload
}

pkg_postinst() {
	einfo "Consider installing sys-apps/fakeroot for use with the ipkg-build command,"
	einfo "that makes it possible to build packages as a normal user."
}
