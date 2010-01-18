# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-2.3.5-r1.ebuild,v 1.4 2010/01/18 20:20:15 ranger Exp $

EAPI=2

USE_RUBY="ruby18"

# The default test task tries to test activerecord with SQLite as well.
RUBY_FAKEGEM_TASK_TEST="test_action_pack"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"

LICENSE="MIT"
SLOT="2.3"
KEYWORDS="~amd64 ~ppc ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend "~dev-ruby/activesupport-${PV}
	>=dev-ruby/rack-1.0.1 <dev-ruby/rack-1.1.0"

ruby_add_bdepend test "~dev-ruby/activerecord-${PV}"

all_ruby_prepare() {
	# Custom template not found in package
	sed -i -e '/horo/d' Rakefile || die

	# This tries to load a “vendorized” copy of activerecord that we
	# will never have.
	sed -i -e '/PATH_TO_AR/s:^:#:' test/active_record_unit.rb || die

	# Fix the testsuite, the symlink is not present in the gem for
	# some reason
	ln -s ../../symlink_parent test/fixtures/layout_tests/layouts/symlinked
}
