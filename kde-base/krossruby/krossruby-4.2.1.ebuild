# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krossruby/krossruby-4.2.1.ebuild,v 1.3 2009/03/15 16:35:29 ranger Exp $

EAPI="2"

KMNAME="kdebindings"
KMMODULE="ruby/krossruby"
inherit kde4-meta

DESCRIPTION="Ruby plugin for the kdelibs/kross scripting framework."
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-lang/ruby
"
RDEPEND="${DEPEND}"
