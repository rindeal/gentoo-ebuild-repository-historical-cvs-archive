# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/xinetd/xinetd-2.3.4.ebuild,v 1.5 2002/10/05 05:39:25 drobbins Exp $

IUSE="tcpd"

# NB: This ebuild introduces the /etc/xinetd.d includedir with a default
#     /etc/xinetd.conf file.  Check your config files if you're upgrading
#     from an older ebuild version.  You should browse /etc/xinetd.conf
#     and the files in /etc/xinetd.d.  Everything is off by default with
#     access restricted to localhost.

S=${WORKDIR}/${P}
DESCRIPTION="Xinetd is a powerful replacement for inetd, with advanced features"
HOMEPAGE="http://www.xinetd.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="BSD"
SRC_URI="http://www.xinetd.org/${P}.tar.gz"

DEPEND="virtual/glibc tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"
RDEPEND="virtual/glibc sys-devel/perl"

src_compile() {

	local myconf
	use tcpd && myconf="--with-libwrap"

	./configure --with-loadavg --host=${CHOST} ${myconf} || die

	# Parallel make does not work
	make || die
}

src_install() {

	into /usr ; dosbin xinetd/xinetd xinetd/itox
	exeinto /usr/sbin ; doexe ${FILESDIR}/xconv.pl

	newman xinetd/xinetd.conf.man xinetd.conf.5
	newman xinetd/xinetd.log.man xinetd.log.8
	newman xinetd/xinetd.man xinetd.8
	doman xinetd/itox.8
	
	newdoc xinetd/sample.conf xinetd.conf.dist.sample
	newdoc ${FILESDIR}/xinetd.conf xinetd.conf.default
	dodoc AUDIT CHANGELOG README COPYRIGHT

	insinto /etc/xinetd.d ; doins ${FILESDIR}/etc.xinetd.d/*
	exeinto /etc/init.d ; newexe ${FILESDIR}/xinetd.rc6 xinetd
	insinto /etc/conf.d ; newins ${FILESDIR}/xinetd.confd xinetd
	insinto /etc ; doins ${FILESDIR}/xinetd.conf
}
