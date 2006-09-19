# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_pkcs11/pam_pkcs11-0.5.3.ebuild,v 1.4 2006/09/19 21:30:58 dragonheart Exp $

DESCRIPTION="PKCS11 Pam library"
HOMEPAGE="http://www.opensc-project.org/pam_pkcs11"
SRC_URI="http://www.opensc-project.org/files/pam_pkcs11/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="curl ldap pcsc-lite"

DEPEND="
	sys-libs/pam
	curl? ( net-misc/curl )
	ldap? ( net-nds/openldap )
	pcsc-lite? ( sys-apps/pcsc-lite )
	dev-libs/openssl"

src_compile() {
		econf \
			$(use_with curl) \
			$(use_with pcsc-lite pcsclite) \
			$(use_with ldap) \
			|| die "econf failed"

		emake || die "emake failed"
}

src_install() {
		make DESTDIR="${D}" install || die "install failed"

		dodir /lib/security
		dosym ../../usr/lib/security/pam_pkcs11.so /lib/security/

		dodoc NEWS README
		dohtml docs/*.{html,css}
}
