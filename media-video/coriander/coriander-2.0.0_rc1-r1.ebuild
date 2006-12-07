# Copyright 1999-2006 Gentoo Foundation and Pieter Van den Abeele
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/coriander/coriander-2.0.0_rc1-r1.ebuild,v 1.1 2006/12/07 18:28:28 dsd Exp $

inherit eutils

MY_P=${P/_/-}

DESCRIPTION="A Gnome2 GUI for firewire camera control and capture"
HOMEPAGE="http://sourceforge.net/projects/coriander/"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="ffmpeg"

S=${WORKDIR}/${MY_P}


RDEPEND=">=media-libs/libdc1394-2.0.0_rc3
	ffmpeg? ( media-video/ffmpeg )
	media-libs/libsdl
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	gnome-base/libgnomecanvas
	gnome-base/libgnome
	gnome-base/orbit"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Bug #133143, already merged upstream
	epatch ${FILESDIR}/${P}-ffmpeg-configure.patch
}

src_compile() {
	export SSE_CFLAGS="${CFLAGS}"
	econf || die
	emake SSE_CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR=${D} install || die
	dodoc NEWS README AUTHORS
}
