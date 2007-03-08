# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/IceRuby/IceRuby-3.2.0_beta1.ebuild,v 1.1 2007/03/08 21:12:22 caleb Exp $

inherit eutils

MY_P=${P/.0_beta1/b}

DESCRIPTION="ICE middleware C++ bindings"
HOMEPAGE="http://www.zeroc.com/index.html"
SRC_URI="http://www.zeroc.com/download/Ice/3.2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="test debug"

S=${WORKDIR}/${MY_P}

DEPEND="=dev-cpp/Ice-3.2*
	>=dev-lang/ruby-1.8.4
	test? ( >=dev-lang/python-2.4 )"

ICE_HOME=/usr

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${P}-Makefile.patch

	mkdir -p ${S}/bin
	mkdir -p ${S}/lib

	if use amd64; then
		sed -i -e "s:^#LP64:LP64:g" ${S}/config/Make.rules \
		|| die "Failed to set lib64 directory"
	fi

	if ! use debug; then
		sed -i -e "s:#OPTIMIZE:OPTIMIZE:" \
		${S}/config/Make.rules || die "Failed to remove debug"
	fi

	sed -i -e \
	"s:.*CXXFLAGS[^\+]*\=\s:CXXFLAGS = ${CXXFLAGS} :g" \
	${S}/config/Make.rules.Linux || die "CXXFLAGS patching failed!"
}

src_compile() {
	cd ${S}
	export ICE_HOME=/usr
	make || die "Died during make"
}

src_install() {
	export ICE_HOME=/usr
	make DESTDIR="${D}" install || die "Install Failed!"
}

src_test() {
	export ICE_HOME=/usr
	make test || die "Test failed"
}
