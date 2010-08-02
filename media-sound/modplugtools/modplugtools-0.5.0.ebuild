# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/modplugtools/modplugtools-0.5.0.ebuild,v 1.1 2010/08/02 19:31:43 ssuominen Exp $

EAPI=2

DESCRIPTION="libmodplug based module players modplug123 and modplugplay"
HOMEPAGE="http://modplug-xmms.sourceforge.net/"
SRC_URI="mirror://sourceforge/modplug-xmms/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/libao-0.8.0
	>=media-libs/libmodplug-0.8.8.1
	!media-sound/modplugplay"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
