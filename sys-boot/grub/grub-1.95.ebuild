# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/grub/grub-1.95.ebuild,v 1.2 2007/06/24 18:11:08 peper Exp $

inherit mount-boot eutils flag-o-matic toolchain-funcs

DESCRIPTION="GNU GRUB 2 boot loader"
HOMEPAGE="http://www.gnu.org/software/grub/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	ftp://alpha.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS=""
IUSE="static netboot custom-cflags"

DEPEND=">=sys-libs/ncurses-5.2-r5
	dev-libs/lzo"
PROVIDE="virtual/bootloader"

src_compile() {
	use amd64 && multilib_toolchain_setup x86
	use custom-cflags || unset CFLAGS LDFLAGS
	use static && append-ldflags -static

	econf \
		--prefix=/ \
		--datadir=/usr/lib \
		|| die "econf failed"
	emake || die "making regular stuff"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
