# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/fam/fam-2.7.0.ebuild,v 1.1 2003/12/07 23:19:54 foser Exp $

inherit libtool eutils

DESCRIPTION="FAM, the File Alteration Monitor"
SRC_URI="ftp://oss.sgi.com/projects/fam/download/stable/${P}.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/fam/"

KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
IUSE=""

DEPEND=">=net-nds/portmap-5b-r6"

src_install() {

	einstall || die

	dosed -i -e "s:local_only = false:local_only = true:g" conf/fam.conf

	exeinto /etc/init.d
	doexe ${FILESDIR}/famd

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS TODO README

}

pkg_postinst() {

	einfo "To enable fam by on boot you will have to add it to the"
	einfo "default profile, issue the following command as root to do so."
	echo
	einfo "rc-update add famd default"

	# temporary warning for people upgrading
	# 6-12-03 foser <foser@gentoo.org>
	echo
	echo
	ewarn "IMPORTANT INFO FOR USERS UPGRADING FROM OLDER (<2.7.0) FAM VERSIONS :"
	echo
	einfo "With the 2.7.0 version the fam daemon moved to sbin and was"
	einfo "renamed from 'fam' to 'famd'. These changes are for consistency"
	einfo "reasons also applied to the Gentoo init script. This means you"
	einfo "will have to remove fam from the default runlevel and add famd."
	einfo "This can be done by issueing the following commands :"
	echo
	einfo "rc-update del fam"
	einfo "rc-update add famd default"
	einfo "rm /etc/init.d/fam"
	echo
	einfo "The last command removes the old init script."

}
