# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/domain_name/domain_name-0.5.3.ebuild,v 1.2 2012/09/27 10:32:13 ssuominen Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_RECIPE_TEST="none"
RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="Domain Name manipulation library for Ruby"
HOMEPAGE="https://github.com/knu/ruby-domain_name"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64"
IUSE="test"

ruby_add_rdepend ">=dev-ruby/unf-0.0.5-r1"

ruby_add_bdepend "
	test? (
		>=dev-ruby/test-unit-2.5.1-r1
		dev-ruby/shoulda
	)"

all_ruby_prepare() {
	sed -i -e '/bundler/,/end/ d; i gem "unf"' test/helper.rb || die
	rm Gemfile* || die

	# Remove development dependencies
	sed -i -e '/dependency.*\(shoulda\|bundler\|jeweler\|rdoc\)/d' \
		${RUBY_FAKEGEM_GEMSPEC} || die
}

each_ruby_test() {
	ruby-ng_testrb-2 -Ilib:test test/test_*.rb
}
