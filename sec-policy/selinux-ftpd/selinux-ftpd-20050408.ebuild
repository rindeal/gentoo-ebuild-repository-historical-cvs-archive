# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-ftpd/selinux-ftpd-20050408.ebuild,v 1.1 2005/04/23 17:59:59 kaiowas Exp $

inherit selinux-policy

TEFILES="ftpd.te"
FCFILES="ftpd.fc"
IUSE=""

DESCRIPTION="SELinux policy for ftp daemons"

KEYWORDS="~x86 ~ppc ~sparc ~amd64"

