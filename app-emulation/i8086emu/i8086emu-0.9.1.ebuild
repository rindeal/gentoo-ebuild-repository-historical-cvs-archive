# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/i8086emu/i8086emu-0.9.1.ebuild,v 1.7 2005/01/01 14:13:35 eradicator Exp $

inherit eutils

DESCRIPTION="Emulator for the Intel 8086 microprocessor"
HOMEPAGE="http://i8086emu.sourceforge.net/"
SRC_URI="mirror://sourceforge/i8086emu/i8086emu-src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE="X"

RDEPEND="sys-libs/ncurses
	virtual/libc
	X? ( dev-libs/glib
		dev-libs/atk
		media-libs/fontconfig
		x11-libs/pango
		virtual/x11
		media-libs/freetype
		sys-libs/zlib
		dev-libs/expat
		>=x11-libs/gtk+-2.0.0 )"
DEPEND="${RDEPEND}
	sys-devel/gcc
	sys-devel/autoconf
	dev-util/pkgconfig"

S=${WORKDIR}/i8086emu-src-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	local myconf
	use X || myconf="usegtk=0"

	econf ${myconf} || die "Failed to configure"
	emake || die "Failed to make"
}

src_install() {
	make DESTDIR=${D} infodir=/usr/share/doc/${P} examplesdir=/usr/share/doc/${P}/examples install || die
}
