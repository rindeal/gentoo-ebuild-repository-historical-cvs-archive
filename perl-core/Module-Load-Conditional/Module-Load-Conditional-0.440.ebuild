# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Module-Load-Conditional/Module-Load-Conditional-0.440.ebuild,v 1.4 2011/05/02 19:55:28 grobian Exp $

EAPI=3

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.44
inherit perl-module

DESCRIPTION="Looking up module information / loading at runtime"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=">=virtual/perl-Module-Load-0.12
	>=virtual/perl-Module-CoreList-0.22
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Params-Check
	virtual/perl-version"
RDEPEND="${DEPEND}"

SRC_TEST=do
