# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/capi4hylafax/capi4hylafax-01.03.00.3.ebuild,v 1.1 2005/10/02 23:07:41 sbriesen Exp $

inherit eutils versionator

FAX_SPOOL_DIR="/var/spool/fax"

MY_PV="$(get_version_component_range 1-3)"
MY_PP="$(get_version_component_range 4)"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="capi4hylafax adds a faxcapi modem to the hylafax enviroment."
SRC_URI="http://ftp.debian.org/debian/pool/main/c/capi4hylafax/${MY_P/-/_}.orig.tar.gz
		http://ftp.debian.org/debian/pool/main/c/capi4hylafax/${MY_P/-/_}-${MY_PP}.diff.gz"
HOMEPAGE="http://packages.qa.debian.org/c/capi4hylafax.html"

S="${WORKDIR}/${MY_P}"

IUSE="unicode"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="net-dialup/capi4k-utils
	media-libs/tiff
	media-libs/jpeg
	sys-libs/zlib"

RDEPEND="${DEPEND}
	dev-util/dialog"

src_unpack() {
	unpack ${A}
	mv "${S}.orig" "${S}"
	cd "${S}"

	# apply debian patches + update configs
	epatch "${WORKDIR}/${MY_P/-/_}-${MY_PP}.diff"
	libtoolize --copy --force

	# fix location of fax spool
	for i in config.faxCAPI Readme_src src/defaults.h.in debian/*.1; do
		[ -f "${i}" ] && sed -i -e "s:/var/spool/hylafax:${FAX_SPOOL_DIR}:g" "${i}"
	done

	# fix location of fax config
	sed -i -e "s:/etc/hylafax:${FAX_SPOOL_DIR}/etc:g" setupconffile

	# fix name and location of logfile
	sed -i -e "s:/var/spool/fax/log/capi4hylafax:/var/log/${PN}.log:" config.faxCAPI
	sed -i -e "s:/tmp/capifax.log:/var/log/${PN}.log:" src/defaults.h.in config.faxCAPI

	# patch man pages
	sed -i -e "s:/usr/share/doc/capi4hylafax/:/usr/share/doc/${PF}/html/:g" \
		-e "s:c2send:c2faxsend:g" -e "s:c2recv:c2faxrecv:g" \
		-e "s:CAPI4HYLAFAXCONFIG \"1\":C2FAXADDMODEM \"8\":g" \
		-e "s:capi4hylafaxconfig:c2faxaddmodem:g" debian/*.1
	cp -f debian/capi4hylafaxconfig.1 debian/c2faxaddmodem.8

	# if specified, convert all relevant files from latin1 to UTF-8
	if use unicode; then
		for i in config.faxCAPI; do
			einfo "Converting ${i} to UTF-8"
			iconv -f latin1 -t utf8 -o "${i}~" "${i}" && mv -f "${i}~" "${i}" || rm -f "${i}~"
		done
	fi
}

src_compile() {
	econf --with-hylafax-spooldir="${FAX_SPOOL_DIR}" || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	keepdir "${FAX_SPOOL_DIR}"/{etc,recvq,pollq,log,status}
	fowners uucp:uucp "${FAX_SPOOL_DIR}" "${FAX_SPOOL_DIR}"/{etc,recvq,pollq,log,status}
	fperms 0700 "${FAX_SPOOL_DIR}"

	make DESTDIR="${D}" install || die "make install failed"

	# install setup script
	newsbin setupconffile c2faxaddmodem

	# install sample config
	insinto "${FAX_SPOOL_DIR}/etc"
	newins config.faxCAPI config.faxCAPI.default

	# install docs
	dodoc AUTHORS ChangeLog Readme_src
	newdoc debian/changelog ChangeLog.debian
	dohtml README.html LIESMICH.html

	# install man pages
	doman debian/c2fax*.[18]

	# install examples
	docinto examples
	dodoc sample_faxrcvd faxrcvd
	newdoc debian/faxsend sample_faxsend
	newdoc sample_AVMC4_config.faxCAPI config.faxCAPI_AVMC4
	dodoc config.faxCAPI fritz_pic.tif GenerateFileMail.pl

	# finally install init-script + config
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
}

pkg_postinst() {
	einfo "To use capi4hylafax:"
	einfo "Make sure that your isdn/capi devices are owned by"
	einfo "the \"uucp\" user (see udev or devfsd config)."
	einfo "Modify ${FAX_SPOOL_DIR}/etc/config.faxCAPI"
	einfo "to suit your system."

	if [ -f "${FAX_SPOOL_DIR}/etc/config.faxCAPI" ]; then
		einfo
		einfo "If you're upgrading from a previous version"
		einfo "please check for new or changed options."
		einfo "A sample default config is installed as:"
		einfo "${FAX_SPOOL_DIR}/etc/config.faxCAPI.default"
	else
		# install default config
		cp -f "${FAX_SPOOL_DIR}/etc/config.faxCAPI.default" \
			"${FAX_SPOOL_DIR}/etc/config.faxCAPI"
	fi

	einfo
	einfo "You should also check special options in:"
	einfo "/etc/conf.d/${PN}"
	einfo
	einfo "If you want to use capi4hylafax together with"
	einfo "hylafax, then please emerge net-misc/hylafax"
	einfo
	einfo "Then append the following line to your hylafax"
	einfo "config file (${FAX_SPOOL_DIR}/etc/config):"
	einfo "SendFaxCmd:             /usr/bin/c2faxsend"
}
