# Copyrigth 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-1.8.10-r1.ebuild,v 1.3 2002/10/01 00:27:25 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/1.8/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

RDEPEND="=x11-libs/gtk+-1.2*
	python? ( >=dev-lang/python-2.2-r7 )
	perl?   ( >=sys-devel/perl-5.6.1 )
	gnome?  ( <gnome-base/gnome-panel-1.5.0
				>=media-libs/gdk-pixbuf-0.11.0-r1 )
	ssl?    ( >=dev-libs/openssl-0.9.6a )"

DEPEND="${RDEPEND}
	nls?    ( >=sys-devel/gettext-0.10.38 )"

src_unpack() {

	unpack ${A}
	
	cd ${S}
	
	patch -p1 <${FILESDIR}/xc1810fixme3.diff
	cp configure configure.orig

	use python && ( \
		local mylibs=`/usr/bin/python-config`
		sed -e 's:PY_LIBS=".*":PY_LIBS="'"$mylibs"'":' \
			configure.orig > configure
	)
}

src_compile() {

	local myopts myflags

	if [ ! `use perl` ]; then
		use gnome \
			&& myopts="${myopts} --enable-gnome --enable-panel" \
			   CFLAGS="${CFLAGS} -I/usr/include/orbit-1.0" \
			|| myopts="${myopts} --enable-gtkfe --disable-gnome --disable-zvt --disable-gdk-pixbuf"
	else
		myopts="${myopts} --disable-gnome"
    fi
	
	use gtk \
		|| myopts="${myopts} --disable-gtkfe"
	
	use ssl \
		&& myopts="${myopts} --enable-openssl"

	use perl \
		|| myopts="${myopts} --disable-perl"

	use nls \
		&& myopts="${myopts} --enable-hebrew --enable-japanese-conv" \
		|| myopts="${myopts} --disable-nls"

	if use x86
	then
		use mmx	\
			&& myopts="${myopts} --enable-mmx"	\
			|| myopts="${myopts} --disable-mmx"
	fi
	
	use ipv6 \
		&& myopts="${myopts} --enable-ipv6"
	
	use python \
		&& myflags="`python-config`" \
	 	&& myopts="${myopts} --enable-python"
	
	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		${myopts} || die
	
	emake || die
}

src_install() {
	
	use kde && ( \
		make \
			prefix=${D}/usr \
			install || die
	) || ( \
		make \
			prefix=${D}/usr \
			install || die
	)

	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins xchat.desktop
	)

	dodoc AUTHORS COPYING ChangeLog README
}
