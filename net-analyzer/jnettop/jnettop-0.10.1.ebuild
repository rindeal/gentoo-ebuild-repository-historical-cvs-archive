# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/jnettop/jnettop-0.10.1.ebuild,v 1.1 2005/01/09 07:34:40 dragonheart Exp $

DESCRIPTION="A top like console network traffic visualiser"
HOMEPAGE="http://jnettop.kubs.info/"
SRC_URI="http://jnettop.kubs.info/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="net-libs/libpcap
	>=dev-libs/glib-2.0.1"

src_install() {
	emake DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
