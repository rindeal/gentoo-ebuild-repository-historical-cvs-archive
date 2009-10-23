# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.22.ebuild,v 1.1 2009/10/23 14:46:04 graaff Exp $

inherit elisp-common ruby

DESCRIPTION="A multipurpose documentation format for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/project/rdtool"
SRC_URI="http://www.moonwolf.com/ruby/archive/${P}.tar.gz"
LICENSE="Ruby GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs"

USE_RUBY="ruby18"

DEPEND=""
RDEPEND="dev-ruby/amstd
	emacs? ( virtual/emacs )"
SITEFILE=50${PN}-gentoo.el

src_test() {
	${RUBY} -Ilib test.rb
}

src_install() {
	RUBY_ECONF="${RUBY_ECONF} ${EXTRA_ECONF}"

	${RUBY} setup.rb config --prefix=/usr "$@" \
		${RUBY_ECONF} || die "setup.rb config failed"
	${RUBY} setup.rb install --prefix="${D}" "$@" \
		${RUBY_ECONF} || die "setup.rb install failed"

	if use emacs ; then
		elisp-install ${PN} utils/rd-mode.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	dodoc HISTORY README.*
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
