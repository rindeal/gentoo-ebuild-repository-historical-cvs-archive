# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-gui/gnustep-gui-0.8.3.ebuild,v 1.2 2003/02/04 18:52:56 raker Exp $

DESCRIPTION="GNUstep AppKit implementation"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/core/${P}.tar.gz"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc "
DEPEND=">=dev-util/gnustep-base-1.5.1
	>=media-libs/tiff-3.5.7
	>=media-libs/jpeg-6b-r2" 
S=${WORKDIR}/${P}

src_compile() {

	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	./configure --prefix=/usr/GNUstep \
		--with-jpeg-library=/usr/lib \
		--with-jpeg-include=/usr/include \
		--with-tiff-library=/usr/lib \
		--with-tiff-include=/usr/include \
		|| die "configure failed"

	make LD_LIBRARY_PATH=$LD_LIBRARY_PATH || die
}

src_install () {

	. /usr/GNUstep/System/Makefiles/GNUstep.sh

	make \
		GNUSTEP_INSTALLATION_DIR=${D}/usr/GNUstep/System \
		INSTALL_ROOT_DIR=${D} \
		install || die "install failed"

}
