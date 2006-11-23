# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/eggdrop/eggdrop-1.6.17-r2.ebuild,v 1.13 2006/11/23 17:27:38 vivo Exp $

inherit eutils

MY_P="eggdrop${PV}"
PATCHSET_V="1.4"

DESCRIPTION="An IRC bot extensible with C or Tcl."
HOMEPAGE="http://www.eggheads.org/"
SRC_URI="ftp://ftp.eggheads.org/pub/eggdrop/source/1.6/${MY_P}.tar.gz
	mirror://gentoo/${P}-patches-${PATCHSET_V}.tar.bz2
	http://dev.gentoo.org/~swegener/distfiles/${P}-patches-${PATCHSET_V}.tar.bz2"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="debug static mysql postgres ssl vanilla"

DEPEND="dev-lang/tcl
	!vanilla? (
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql )
		ssl? ( dev-libs/openssl )
	)"

S="${WORKDIR}"/${MY_P}

src_unpack()  {
	unpack ${A}
	cd "${S}"

	if use vanilla
	then
		einfo "Excluding patches that install additional modules, this effectively"
		einfo "disables the mysql, postgres and ssl USE flags."
		echo
		rm "${WORKDIR}"/patch/[12345678]*.patch
	fi

	EPATCH_SUFFIX="patch" epatch || die "epatch failed"
}

src_compile() {
	local target=""

	use mysql    || ( echo mysql ; echo mystats ) >>disabled_modules
	use postgres || echo pgstats >>disabled_modules
	use static   && ( echo rijndael ; echo twofish ) >>disabled_modules

	econf $(use_with ssl) || die "econf failed"

	make config || die "module config failed"

	if use static && use debug
	then
		target="sdebug"
	elif use static
	then
		target="static"
	elif use debug
	then
		target="debug"
	fi

	emake -j1 ${target} || die "emake ${target} failed"
}

src_install() {
	local a b
	make DEST="${D}"/opt/eggdrop install || die "make install failed"

	for a in doc/*
	do
		[ -f ${a} ] && dodoc ${a}
	done

	cd "${S}"/src/mod
	for a in *.mod
	do
		for b in README UPDATES INSTALL TODO CONTENTS
		do
			[[ -f ${a}/${b} ]] && newdoc ${a}/${b} ${b}.${a}
		done
	done

	cd "${S}"

	dodoc text/motd.*

	use vanilla || dodoc \
		src/mod/botnetop.mod/botnetop.conf \
		src/mod/gseen.mod/gseen.conf \
		src/mod/mc_greet.mod/mc_greet.conf \
		src/mod/stats.mod/stats.conf \
		src/mod/away.mod/away.doc \
		src/mod/rcon.mod/matchbot.tcl \
		src/mod/mystats.mod/tools/mystats.{conf,sql} \
		src/mod/pgstats.mod/tools/{pgstats.conf,setup.sql}

	dohtml doc/html/*.html

	dobin "${FILESDIR}"/eggdrop-installer
	doman doc/man1/eggdrop.1
}

pkg_postinst() {
	einfo
	einfo "NOTE: IPV6 support has been dropped by upstream maintainers."
	einfo "Please run /usr/bin/eggdrop-installer to install your eggdrop bot."
	einfo
}
