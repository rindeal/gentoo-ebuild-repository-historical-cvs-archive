# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-digitaledge/xf86-input-digitaledge-1.0.1.3.ebuild,v 1.1 2005/12/23 20:08:12 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for digitaledge input devices"
KEYWORDS="~x86"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
