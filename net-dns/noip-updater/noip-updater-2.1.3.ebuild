# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/noip-updater/noip-updater-2.1.3.ebuild,v 1.1 2006/10/29 02:21:31 dragonheart Exp $

inherit eutils

IUSE=""

MY_P=${P/-updater/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="no-ip.com dynamic DNS updater"
HOMEPAGE="http://www.no-ip.com"
SRC_URI="http://www.no-ip.com/client/linux/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND} sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/noip-2.1.3-cflags.patch || die
	sed -i \
		-e "s:\(#define CONFIG_FILEPATH\).*:\1 \"/etc\":" \
		-e "s:\(#define CONFIG_FILENAME\).*:\1 \"/etc/no-ip2.conf\":" \
		noip2.c || die
}

src_compile() {
	emake \
		PREFIX=/usr \
		CONFDIR=/etc || die
}

src_install() {
	into /usr
	dosbin noip2
	dodoc README.FIRST COPYING
	exeinto /etc/init.d
	newexe ${FILESDIR}/noip2.start noip
	prepalldocs
}

pkg_postinst() {
	einfo "Configuration can be done manually via:"
	einfo "/usr/sbin/noip2 -C or "
	einfo "first time you use the /etc/init.d/noip script; or"
	einfo "by using this ebuild's config option."
}

pkg_config() {
	cd /tmp
	einfo "Answer the following questions."
	noip2 -C || die
}

