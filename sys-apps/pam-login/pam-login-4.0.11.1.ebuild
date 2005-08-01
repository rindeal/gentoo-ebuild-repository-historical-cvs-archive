# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pam-login/pam-login-4.0.11.1.ebuild,v 1.1 2005/08/01 11:48:13 azarah Exp $

inherit eutils libtool flag-o-matic pam

# Do we want to backup an old login.defs, and forcefully
# install a new version?
FORCE_LOGIN_DEFS="no"

MY_PN="shadow"
S="${WORKDIR}/${MY_PN}-${PV}"
DESCRIPTION="Login, lastlog and faillog for PAM based systems"
HOMEPAGE="http://shadow.pld.org.pl/"
SRC_URI="ftp://ftp.pld.org.pl/software/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="livecd nls selinux"

DEPEND="virtual/libc
	sys-libs/pam
	>=sys-apps/shadow-4.0.11.1
	selinux? ( sys-libs/libselinux )"
# We need sys-apps/shadow-4.0.7-r1, as that no longer installs login.pamd

src_unpack() {
	unpack ${A}

	cd ${S}

	# The new configure changes do not detect utmp/logdir properly
	epatch "${FILESDIR}"/${PN}-4.0.10-fix-configure.patch

	elibtoolize
	epunt_cxx
}

src_compile() {
	append-ldflags -Wl,-z,now
	[[ ${CTARGET:-${CHOST}} != ${CHOST} ]] \
		&& export ac_cv_func_setpgrp_void=yes
	econf \
		--disable-desrpc \
		--with-libcrypt \
		--with-libcrack \
		--enable-shared=no \
		--enable-static=yes \
		--with-libpam \
		$(use_with skey libskey) \
		$(use_with selinux) \
		$(use_enable nls) \
		|| die "bad configure"

	cd ${S}/man
	emake SUBDIRS="" \
	      man_XMANS="faillog.5.xml faillog.8.xml lastlog.8.xml \
	                 login.1.xml login.access.5.xml login.defs.5.xml" \
	      man_MANS="faillog.5 faillog.8 lastlog.8 \
	                login.1 login.access.5 login.defs.5" \
		|| die "emake man failed"
	cd ${S}/libmisc
	emake || die "emake libmisc failed"
	cd ${S}/lib
	emake || die "emake lib failed"
	cd ${S}/src
	emake faillog lastlog login || die "emake faillog lastlog login failed"
}

src_install() {
	cd ${S}/man
	make SUBDIRS="" \
	     man_XMANS="faillog.5.xml faillog.8.xml lastlog.8.xml \
	                login.1.xml login.defs.5.xml" \
	     man_MANS="faillog.5 faillog.8 lastlog.8 \
	               login.1 login.defs.5" \
	     DESTDIR=${D} install || die "emake man failed"
	cd ${S}/src

	into /
	dobin ${S}/src/login
	into /usr
	dobin ${S}/src/{last,fail}log

	newpamd "${FILESDIR}/login.pamd-4.0" login

	insinto /etc
	insopts -m0644
	newins "${FILESDIR}/login.defs-4.0" login.defs

	# Also install another one that we can use to check if
	# we need to update it if FORCE_LOGIN_DEFS = "yes"
	[ "${FORCE_LOGIN_DEFS}" = "yes" ] \
		&& newins "${FILESDIR}/login.defs" login.defs.new

	dodoc ChangeLog NEWS README TODO
}

pkg_preinst() {
	rm -f "${ROOT}/etc/login.defs.new"
}

pkg_postinst() {
	[ "${FORCE_LOGIN_DEFS}" != "yes" ] && return 0

	ewarn "Due to a compatibility issue, ${ROOT}etc/login.defs "
	ewarn "is being updated automatically. Your old login.defs"
	ewarn "will be backed up as:  ${ROOT}etc/login.defs.bak"
	echo

	local CHECK1="`md5sum ${ROOT}/etc/login.defs | cut -d ' ' -f 1`"
	local CHECK2="`md5sum ${ROOT}/etc/login.defs.new | cut -d ' ' -f 1`"

	if [ "${CHECK1}" != "${CHECK2}" ]
	then
		cp -a ${ROOT}/etc/login.defs ${ROOT}/etc/login.defs.bak
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	elif [ ! -f ${ROOT}/etc/login.defs ]
	then
		mv -f ${ROOT}/etc/login.defs.new ${ROOT}/etc/login.defs
	else
		rm -f ${ROOT}/etc/login.defs.new
	fi
}
