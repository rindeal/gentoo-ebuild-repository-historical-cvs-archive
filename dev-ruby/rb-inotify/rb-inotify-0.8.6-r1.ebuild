# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rb-inotify/rb-inotify-0.8.6-r1.ebuild,v 1.1 2011/08/14 07:11:41 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_EXTRAINSTALL="VERSION"

RUBY_FAKEGEM_GEMSPEC="rb-inotify.gemspec"

inherit ruby-fakegem

DESCRIPTION="A thorough inotify wrapper for Ruby using FFI."
HOMEPAGE="https://github.com/nex3/rb-inotify"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "virtual/ruby-ffi"

ruby_add_bdepend "doc? ( dev-ruby/yard )"

each_ruby_prepare() {
	case ${RUBY} in
		*jruby)
			# jruby has a native implementation and should not list ffi
			# in the gemspec.
			sed -i -e '/ffi/d' rb-inotify.gemspec || die
			;;
		*)
			;;
	esac
}
