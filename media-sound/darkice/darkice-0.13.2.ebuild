# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.13.2.ebuild,v 1.6 2004/08/07 23:24:40 slarti Exp $

IUSE="encode oggvorbis"

DESCRIPTION="IceCast live streamer delivering Ogg and mp3 streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="encode?	( >=media-sound/lame-1.89 )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

src_compile() {
	local myconf=""

	if ! use encode && ! use oggvorbis
	then

		eerror "You need support for mp3 or Ogg Vorbis enconding for this"
		eerror "package. Please merge again with at least one of the "
		eerror "\`encode' and \`oggvorbis' USE flags enabled:"
		eerror
		eerror "  # USE=\"encode\" emerge darkice"
		eerror "  # USE=\"oggvorbis\" emerge darkice"
		die "Won't build without support for lame nor vorbis"
	fi

	use encode    || myconf="--without-lame"
	use oggvorbis || myconf="--without-vorbis"

	econf ${myconf} || die "econf failed"

	emake || die "Compilation failed"
}

src_install() {
	einstall darkicedocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
