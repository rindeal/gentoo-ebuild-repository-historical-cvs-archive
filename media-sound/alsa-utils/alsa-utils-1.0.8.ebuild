# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-1.0.8.ebuild,v 1.6 2005/03/27 15:15:44 gmsoft Exp $

IUSE=""

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~alpha amd64 hppa ~mips ppc ~ppc64 sparc x86"

DEPEND=">=sys-libs/ncurses-5.1
	dev-util/dialog
	>=media-libs/alsa-lib-1.0.8"

RDEPEND="${DEPEND}
	sys-apps/pciutils"

src_install() {
	local ALSA_UTILS_DOCS="ChangeLog README TODO
		seq/aconnect/README.aconnect
		seq/aseqnet/README.aseqnet"

	make DESTDIR="${D}" install || die "Installation Failed"

	dodoc ${ALSA_UTILS_DOCS}
	newdoc alsamixer/README README.alsamixer

	insinto /etc/conf.d
	newins ${FILESDIR}/alsasound.confd alsasound
	insinto /etc/modules.d
	newins ${FILESDIR}/alsa-modules.conf-rc alsa
	exeinto /etc/init.d
	doexe ${FILESDIR}/alsasound
}

pkg_postinst() {
	echo
	einfo "The alsasound initscript is now provided by alsa-utils"
	einfo "instead of alsa-driver for compatibility with kernel-sources"
	einfo "which provide ALSA internally."
	echo
	einfo "To take advantage of this, and automate the process of"
	einfo "loading and unloading the ALSA sound drivers as well as"
	einfo "storing and restoring sound-card mixer levels you should"
	einfo "add alsasound to the boot runlevel. You can do this as"
	einfo "root like so:"
	einfo "	# rc-update add alsasound boot"
	echo
	einfo "You will also need to edit the file /etc/modules.d/alsa"
	einfo "and run modules-update. You can do this like so:"
	einfo "	# nano -w /etc/modules.d/alsa && modules-update"
	echo

	if use sparc; then
		ewarn "Old versions of alsa-drivers had a broken snd-ioctl32 module"
		ewarn "which causes sparc64 machines to lockup on such tasks as"
		ewarn "changing the volume.  Because of this, it is VERY important"
		ewarn "that you do not use the snd-ioctl32 modules contained in"
		ewarn "development-sources or <=gentoo-dev-sources-2.6.7-r14.  Doing so"
		ewarn "may result in an unbootable system if you start alsasound at boot."
	fi
}
