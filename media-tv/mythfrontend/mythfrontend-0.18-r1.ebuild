# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythfrontend/mythfrontend-0.18-r1.ebuild,v 1.1 2005/05/11 20:49:53 cardoe Exp $

inherit flag-o-matic eutils debug

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/mythtv-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa altivec arts cle266 debug dvb ieee1394 jack joystick lcd lirc mmx nvidia oggvorbis opengl oss xv"

DEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	virtual/x11
	>=x11-libs/qt-3.1.1
	dev-db/mysql
	alsa? ( >=media-libs/alsa-lib-0.9 )
	arts? ( kde-base/arts )
	dvb? ( media-libs/libdvb )
	jack? ( media-sound/jack-audio-connection-kit )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )
	oggvorbis? ( media-libs/libvorbis )
	opengl? ( virtual/opengl )
	ieee1394? ( >=sys-libs/libraw1394-1.2.0 )
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.34 )"

# ieee1394 also needs >=sys-libs/libiec61883-1.0.0

RDEPEND="${DEPEND}
	!media-tv/mythtv"

pkg_setup() {

	if ! built_with_use x11-libs/qt mysql ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs MySQL support"
	fi

	if use nvidia; then
		echo
		ewarn "You enabled the 'nvidia' USE flag, you must have a GeForce 4 or"
		ewarn "greater to use this. Otherwise, you'll have crashes with MythTV"
		echo
	fi

	einfo
	einfo "Please note, this ebuild does not use your CFLAGS and CXXFLAGS. It determines"
	einfo "a sane set and uses those. Please do not attempt to override this behavior."
	einfo

}

# memory in case I ever bring it back
#src_unpack() {
#	unpack ${A}
#
#	# Fix bugs 40964 and 42943.
#	filter-flags -fforce-addr -fPIC -momit-leaf-frame-pointer
#	is-flag "-fomit-frame-pointer" || append-flags "-fomit-frame-pointer"
#}

src_compile() {
	use cle266 && use nvidia && die "You can not have USE="cle266" and USE="nvidia" at the same time. Must disable one or the other."
	local myconf="$(use_enable altivec)
		$(use_enable oss audio-oss)
		$(use_enable alsa audio-alsa)
		$(use_enable arts audio-arts)
		$(use_enable jack audio-jack)
		$(use_enable lirc)
		$(use_enable joystick joystick-menu)
		$(use_enable cle266 xvmc-vld)
		$(use_enable dvb)
		$(use_enable dvb dvb-eit)
		--dvb-path=/usr/include
		$(use_enable opengl opengl-vsync)
		$(use_enable oggvorbis vorbis)
		$(use_enable nvidia xvmc)
		$(use_enable xv)
		--disable-directfb
		--enable-x11
		--enable-proc-opt"

	if use mmx || use amd64; then
		myconf="${myconf} --enable-mmx"
	else
		myconf="${myconf} --disable-mmx"
	fi

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=release"
	fi

	hasq distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	hasq ccache ${FEATURES} || myconf="${myconf} --distable-ccache"

	# depends on bug # 89799
	# $(use_enable ieee1394 firewire)

	##Backend Removal
	cd ${S}
	sed -e "s:CONFIG  += linux backend:CONFIG  += linux:" \
		-i 'settings.pro' || die "Removal of mythbackend failed"

	# let MythTV come up with our CFLAGS. Upstream will support this
	CFLAGS=""
	CXXFLAGS=""
	econf ${myconf} || die "configure died"

	qmake -o "Makefile" mythtv.pro || die "qmake failed"
	emake || die "emake failed"

}

src_install() {

	einstall INSTALL_ROOT="${D}" || die "install failed"
	for doc in AUTHORS COPYING FAQ UPGRADING ChangeLog README; do
		test -e "${doc}" && dodoc ${doc}
	done

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /var/log/mythtv
}
