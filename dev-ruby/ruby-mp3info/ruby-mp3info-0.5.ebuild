# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-mp3info/ruby-mp3info-0.5.ebuild,v 1.1 2005/12/06 23:04:40 citizen428 Exp $

inherit ruby gems

DESCRIPTION="A pure Ruby library for access to mp3 files (internal infos and tags)"
HOMEPAGE="http://rubyforge.org/projects/ruby-mp3info/"
SRC_URI="http://gems.rubyforge.org/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
USE_RUBY="any"
DEPEND="virtual/ruby"

