# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gdkimlib/ruby-gdkimlib-0.34.ebuild,v 1.6 2004/04/16 23:53:42 dholm Exp $

inherit ruby

S=${WORKDIR}/ruby-gnome-all-${PV}/gdkimlib
DESCRIPTION="Ruby GdkImlib bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 alpha ~ppc"
USE_RUBY="ruby16 ruby18 ruby19"

DEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*
	>=dev-ruby/ruby-gtk-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install() {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
