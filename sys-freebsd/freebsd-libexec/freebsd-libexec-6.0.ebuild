# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-libexec/freebsd-libexec-6.0.ebuild,v 1.1 2006/04/01 16:43:51 flameeyes Exp $

inherit bsdmk freebsd pam

DESCRIPTION="FreeBSD libexec things"
SLOT="0"
KEYWORDS="~x86-fbsd"

IUSE="lukemftpd pam ssl kerberos ipv6 nis"

SRC_URI="mirror://gentoo/${LIBEXEC}.tar.bz2
	mirror://gentoo/${UBIN}.tar.bz2
	mirror://gentoo/${BIN}.tar.bz2
	mirror://gentoo/${CONTRIB}.tar.bz2
	mirror://gentoo/${LIB}.tar.bz2
	mirror://gentoo/${ETC}.tar.bz2
	mirror://gentoo/${USBIN}.tar.bz2"

RDEPEND="=sys-freebsd/freebsd-lib-${RV}*
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	=sys-freebsd/freebsd-mk-defs-${RV}*
	=sys-freebsd/freebsd-sources-${RV}*
	=sys-freebsd/freebsd-headers-${RV}*"

S="${WORKDIR}/libexec"

pkg_setup() {
	use lukemftpd && mymakeopts="${mymakeopts} WANT_LUKEMFTPD= "
	use pam || mymakeopts="${mymakeopts} NO_PAM= "
	use ssl || mymakeopts="${mymakeopts} NO_OPENSSL= NO_CRYPT= "
	use kerberos || mymakeopts="${mymakeopts} NO_KERBEROS= "
	use ipv6 || mymakeopts="${mymakeopts} NO_INET6= "
	use nis || mymakeopts="${mymakeopts} NO_NIS= "

	mymakeopts="${mymakeopts} NO_SENDMAIL= NO_PF= "
}

PATCHES="${FILESDIR}/${PN}-setXid.patch
	${FILESDIR}/${PN}-5.3_rc1-ypxfr-makefile.patch"

# Remove sendmail, tcp_wrapper and other useless stuff
REMOVE_SUBDIRS="smrsh mail.local tcpd telnetd rshd rlogind"

src_install() {
	freebsd_src_install

	newpamd ${FILESDIR}/ftpd.pamd ftpd

	insinto /etc
	cd "${WORKDIR}/etc"
	doins gettytab
}
