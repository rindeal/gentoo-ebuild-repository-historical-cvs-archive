# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.9.3-r2.ebuild,v 1.2 2002/11/02 20:11:47 foser Exp $

IUSE="perl gnome ssl gtk python mmx ipv6 nls" 

S=${WORKDIR}/${P}
DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/1.9/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	perl?   ( >=sys-devel/perl-5.6.1 )
	gnome? ( >=x11-libs/libzvt-2.0.1
		 >=gnome-base/libgnome-2.0.1
		 >=gnome-base/gnome-applets-2.0.0
		 >=gnome-base/gnome-panel-2.0.1 )
	ssl?	( >=dev-libs/openssl-0.9.6d )" 
               
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.38 )"


src_unpack() {
	unpack ${A}
	
	#fixes a problem with gtk2.1
	patch -d ${S} -p1 < ${FILESDIR}/${P}-tolowertab.patch
	#adds tint options to menu; patch by foser <foser@gentoo.org>
	patch -d ${S} -p1 < ${FILESDIR}/gentoo-${P}-bgtint.patch	
}


# From the xchat 1.9.3 README_FIRST file:
# (one of the) REMAINING PROBLEMS:
# * can't compile with gnome, panel and zvt support *
# stroke 

src_compile() {

	local myopts myflags

	if [ ! `use perl` ] ; then
		use gnome \
			&& myopts="${myopts} --enable-gnome --enable-panel" \
			|| myopts="${myopts} --enable-gtkfe --disable-gnome --disable-zvt"
		
		use gnome \
			&& CFLAGS="${CFLAGS} -I/usr/include/orbit-2.0" \
			|| myopts="${myopts} --disable-gnome"
	fi

	use gtk \
		|| myopts="${myopts} --disable-gtkfe"
	
	use ssl \
		&& myopts="${myopts} --enable-openssl"

	use perl \
		|| myopts="${myopts} --disable-perl"

	use python \
                || myopts="${myopts} --disable-python"

	use nls \
		&& myopts="${myopts} --enable-hebrew --enable-japanese-conv" \
		|| myopts="${myopts} --disable-nls"

	use mmx	\
		&& myopts="${myopts} --enable-mmx"	\
		|| myopts="${myopts} --disable-mmx"
	
	use ipv6 \
		&& myopts="${myopts} --enable-ipv6"
	
	
	econf \
		--program-suffix=-2 \
		${myopts} || die "Configure failed"
	
	MAKEOPTS="-j1" emake || die "Compile failed"
}

src_install() {

	einstall utildir=${D}${KDEDIR}/share/applnk/Internet install || die "Install failed"

	use gnome && 
	(	insinto /usr/share/gnome/apps/Internet
		doins xchat.desktop  )
	use python &&
	(	dosym /usr/lib/xchat/plugins/python.so-2 /usr/lib/xchat/plugins/python.so )
	use perl &&
	(	dosym /usr/lib/xchat/plugins/perl.so-2 /usr/lib/xchat/plugins/perl.so  )
	dodoc AUTHORS COPYING ChangeLog README
}
