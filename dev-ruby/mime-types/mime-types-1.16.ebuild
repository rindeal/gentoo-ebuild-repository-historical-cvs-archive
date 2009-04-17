# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mime-types/mime-types-1.16.ebuild,v 1.1 2009/04/17 12:46:16 flameeyes Exp $

inherit ruby

DESCRIPTION="Provides a mailcap-like MIME Content-Type lookup for Ruby."
HOMEPAGE="http://rubyforge.org/projects/mime-types"
SRC_URI="mirror://rubyforge/${PN}/${P}.tar.gz"

LICENSE="Ruby Artistic GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="doc? ( dev-ruby/rake )
	test? ( dev-ruby/rake )"

USE_RUBY="ruby18"

src_compile() {
	if use doc; then
		rake rerdoc || die "rake rerdoc failed"
	fi
}

src_test() {
	rake test || die "rake test failed"
}

src_install() {
	pushd lib
	doruby -r * || die "doruby failed"
	popd

	if use doc; then
		dohtml -r doc/* || die "dohtml failed"
	fi

	dodoc History.txt Install.txt README.txt || die "dodoc failed"

	insinto $(${RUBY} -r rbconfig -e 'print Config::CONFIG["sitedir"]')/../gems/1.8/specifications
	newins ${PN}.gemspec ${P}.gemspec || die "Unable to install fake gemspec"
}
