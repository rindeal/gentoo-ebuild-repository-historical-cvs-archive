# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/vlad/vlad-2.0.0.ebuild,v 1.1 2009/08/29 07:02:08 graaff Exp $

inherit gems

DESCRIPTION="Pragmatic application deployment automation, without mercy."
HOMEPAGE="http://rubyhitsquad.com/Vlad_the_Deployer.html"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
USE_RUBY="ruby18"

DEPEND="=dev-ruby/open4-0.9*
	=dev-ruby/rake-0.8*"
RDEPEND="${DEPEND}"
