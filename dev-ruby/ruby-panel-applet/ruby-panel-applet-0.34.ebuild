# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-panel-applet/ruby-panel-applet-0.34.ebuild,v 1.8 2005/09/02 12:38:28 flameeyes Exp $

inherit ruby

S=${WORKDIR}/ruby-gnome-all-${PV}/panel-applet
DESCRIPTION="Ruby Gnome Panel bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 alpha"
IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"

DEPEND="virtual/ruby
	>=dev-ruby/ruby-gnome-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install() {
	make site-install DESTDIR=${D} || die "make site-install failed"
	dodoc [A-Z]*
	cp -r sample ${D}/usr/share/doc/${PF}
}
