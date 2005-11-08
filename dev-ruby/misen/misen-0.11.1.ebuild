# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/misen/misen-0.11.1.ebuild,v 1.2 2005/11/08 19:04:05 killerfox Exp $

inherit ruby

USE_RUBY="ruby16 ruby18 ruby19"

DESCRIPTION="A template library for ruby like amrita"
HOMEPAGE="http://devel.korinkan.co.jp/misen/"
SRC_URI="http://devel.korinkan.co.jp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="virtual/ruby
		>=dev-ruby/dpklib-1.0.0"

src_compile() {
	ruby install.rb config || die 'install.rb config failed'
	ruby install.rb setup || die 'install.rb setup failed'
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die 'install.rb config failed'
	ruby install.rb install || die 'install.rb install failed'
	dodoc README
	docinto samples
	dodoc samples/*
}

