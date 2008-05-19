# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gproftpd/gproftpd-8.3.2.ebuild,v 1.4 2008/05/19 09:44:34 drac Exp $

DESCRIPTION="GTK frontend to proftpd"
HOMEPAGE="http://mange.dynup.net/linux.html"
SRC_URI="http://mange.dynup.net/linux/gproftpd/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc sparc x86"
SLOT="0"

IUSE="gnome ssl"

# Requiring ProFTPD 1.2.9 due to security fixes
RDEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=x11-libs/pango-1.0
	>=dev-libs/atk-1.0
	>=media-libs/freetype-2.0
	ssl? ( >=dev-libs/openssl-0.9.6f )
	>=net-ftp/proftpd-1.2.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local modules includes myconf

	#location of proftpd.conf
	myconf="/etc/proftpd"

	if use ssl; then
		# enable mod_tls
		modules="${modules}:mod_tls"
		includes="${include}:/usr/kerberos/include"
	fi

	econf --sysconfdir=${myconf} \
		--localstatedir=/var \
		--with-modules=${modules} \
		--with-includes=${includes} || die "./configure failed"
	emake || die "Build failure"
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failure"

#         Add the Gnome menu entry
	if use gnome; then
		insinto /usr/share/gnome/apps/Internet/
		doins "${S}"/desktop/net-gproftpd.desktop
	fi

	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	elog "gproftpd looks for your proftpd.conf file in /etc/proftpd"
	elog "run gproftpd with the option -c to specify an alternate location"
	elog "ex: gproftpd -c /etc/proftpd.conf"
	elog "Do NOT edit /etc/conf.d/proftpd with this program"
}
