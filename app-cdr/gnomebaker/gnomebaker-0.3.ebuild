# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.3.ebuild,v 1.4 2005/06/17 11:12:25 herbs Exp $

inherit eutils gnome2 flag-o-matic

DESCRIPTION="GnomeBaker is a GTK2-based CD/DVD burning application."
HOMEPAGE="http://gnomebaker.sf.net"
SRC_URI="mirror://sourceforge/gnomebaker/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="dvdr nls mp3 sox vorbis"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	media-libs/libvorbis"

RDEPEND="${DEPEND}
	mp3? ( media-sound/mpg123 )
	sox? ( media-sound/sox )
	vorbis? ( media-sound/vorbis-tools )
	dvdr? ( app-cdr/dvd+rw-tools )
	virtual/cdrtools"

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=${D}/usr/share/doc/${P} \
		docdir=${D}/usr/share/gnome/help/${PN}/C \
		gnomemenudir=${D}/usr/share/applications
	rm -rf ${D}/usr/share/doc/${P}/*.make ${D}/var
	use nls || rm -rf ${D}/usr/share/locale
}
