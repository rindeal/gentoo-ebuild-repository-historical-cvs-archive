# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-stunnel/selinux-stunnel-2.20120215.ebuild,v 1.2 2012/04/29 10:11:33 swift Exp $
EAPI="4"

IUSE=""
MODS="stunnel"
BASEPOL="2.20120215-r1"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for stunnel"

KEYWORDS="amd64 x86"
