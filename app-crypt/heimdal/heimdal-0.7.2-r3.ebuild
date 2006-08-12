# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/heimdal/heimdal-0.7.2-r3.ebuild,v 1.9 2006/08/12 23:59:18 vapier Exp $

inherit autotools libtool eutils virtualx toolchain-funcs

PATCHVER=0.2
PATCH_P=${P}-gentoo-patches-${PATCHVER}

DESCRIPTION="Kerberos 5 implementation from KTH"
HOMEPAGE="http://www.pdc.kth.se/heimdal/"
SRC_URI="ftp://ftp.pdc.kth.se/pub/heimdal/src/${P}.tar.gz
	http://dev.gentoo.org/~seemant/distfiles/${PATCH_P}.tar.bz2
	mirror://gentoo/${PATCH_P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE="ssl berkdb ipv6 krb4 ldap X"

RDEPEND="ssl? ( dev-libs/openssl )
	berkdb? ( sys-libs/db )
	krb4? ( >=app-crypt/kth-krb-1.2.2-r2 )
	ldap? ( net-nds/openldap )
	sys-libs/ss
	sys-libs/com_err
	sys-libs/cracklib
	!virtual/krb5"
DEPEND="${RDEPEND}"
PROVIDE="virtual/krb5"

GENTOODIR=${WORKDIR}/gentoo

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SUFFIX="patch" epatch ${GENTOODIR}/patches

	AT_M4DIR="cf" eautoreconf
}

src_compile() {
	local myconf=""

	use krb4 \
		&& myconf="${myconf} --with-krb4-config=/usr/athena/bin/krb4-config"

	use ldap && myconf="${myconf} --with-openldap=/usr"

	econf \
		$(use_with ipv6) \
		$(use_with berkdb berkeley-db) \
		$(use_with ssl openssl) \
		$(use_with X x) \
		$(use_with krb4) \
		--enable-kcm \
		--enable-shared \
		--includedir=/usr/include/heimdal \
		--libexecdir=/usr/sbin \
		${myconf} || die "econf failed"

	emake || die

	# Compile the added password checker:
	cd ${S}/lib/kadm5
	tc-export CC
	${CC} -shared -fPIC \
		${CFLAGS} -I${S}/include \
		-DDICTPATH=\"/usr/$(get_libdir)/cracklib_dict\" \
		-o sample_passwd_check.so sample_passwd_check.c -lcrack || \
		die "Failed to compile password checker"
}

src_test() {
	addpredict /proc/fs/openafs/afs_ioctl
	addpredict /proc/fs/nnpfs/afs_ioctl

	if use X ; then
		KRB5_CONFIG=${S}/krb5.conf Xmake check || die
	else
		KRB5_CONFIG=${S}/krb5.conf make check || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	dolib ${S}/lib/kadm5/sample_passwd_check.so

	dodoc ChangeLog README NEWS TODO

	# Begin client rename and install
	for i in {telnetd,ftpd,rshd}
	do
		mv ${D}/usr/share/man/man8/{,k}${i}.8
		mv ${D}/usr/sbin/{,k}${i}
	done

	for i in {rcp,rsh,telnet,ftp,su,login}
	do
		mv ${D}/usr/share/man/man1/{,k}${i}.1
		mv ${D}/usr/bin/{,k}${i}
	done

	mv ${D}/usr/share/man/man5/{,k}ftpusers.5
	mv ${D}/usr/share/man/man5/{,k}login.access.5

	# Create symlinks for the includes
	dosym heimdal /usr/include/gssapi
	dosym heimdal/krb5-types.h /usr/include/krb5-types.h
	dosym heimdal/krb5.h /usr/include/krb5.h
	dosym heimdal/asn1_err.h /usr/include/asn1_err.h
	dosym heimdal/krb5_asn1.h /usr/include/krb5_asn1.h
	dosym heimdal/krb5_err.h /usr/include/krb5_err.h
	dosym heimdal/heim_err.h /usr/include/heim_err.h
	dosym heimdal/k524_err.h /usr/include/k524_err.h
	dosym heimdal/krb5-protos.h /usr/include/krb5-protos.h

	doinitd ${GENTOODIR}/configs/heimdal-kdc
	doinitd ${GENTOODIR}/configs/heimdal-kadmind
	doinitd ${GENTOODIR}/configs/heimdal-kpasswdd

	insinto /etc
	newins ${GENTOODIR}/configs/krb5.conf krb5.conf.example

	sed -i "s:/lib:/$(get_libdir):" ${D}/etc/krb5.conf.example

	if use ldap; then
		insinto /etc/openldap/schema
		doins ${GENTOODIR}/configs/krb5-kdc.schema
	fi

	# default database dir
	keepdir /var/heimdal
}
