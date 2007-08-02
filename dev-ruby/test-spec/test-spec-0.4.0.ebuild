# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/test-spec/test-spec-0.4.0.ebuild,v 1.1 2007/08/02 23:37:56 nichoj Exp $

inherit ruby gems

DESCRIPTION="A library to do Behavior Driven Development with Test::Unit"
HOMEPAGE="http://chneukirchen.org/blog/"
SRC_URI="http://chneukirchen.org/releases/gems/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ruby-1.8.5"
