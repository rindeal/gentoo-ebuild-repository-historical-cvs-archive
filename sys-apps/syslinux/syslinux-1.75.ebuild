# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslinux/syslinux-1.75.ebuild,v 1.5 2002/12/09 04:37:26 manson Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/boot/syslinux/${P}.tar.gz"

KEYWORDS="x86 -ppc -sparc "

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/nasm"

src_compile() {
	emake || die
}

src_install () {
	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc
}
