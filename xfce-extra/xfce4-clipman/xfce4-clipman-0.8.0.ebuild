# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-clipman/xfce4-clipman-0.8.0.ebuild,v 1.11 2007/03/17 21:33:06 vapier Exp $

inherit xfce44

RESTRICT="test"

DESCRIPTION="Xfce4 panel clipboard manager plugin"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

xfce44
xfce44_goodies_panel_plugin
