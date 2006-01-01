# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql/mysql-4.1.16-r30.ebuild,v 1.4 2006/01/01 19:00:30 vivo Exp $

# MYSQL_VERSION_ID will be
# major * 10e6 + minor * 10e4 + micro * 10e2 + gentoo magic number, all [0..99]
# this is an important piece, becouse from this variable depends many of the
# choices the ebuild will do.
# in particular the code below work only with PVR like "5.0.18-r3"
# the result with the previous PVR is "5001803"
MYSQL_VERSION_ID=""
tpv=( ${PV//[-._]/ } ) ; tpv[3]="${PVR:${#PV}}" ; tpv[3]="${tpv[3]##*-r}"
for vatom in 0 1 2 3; do
	# pad to lenght 2
	tpv[${vatom}]="00${tpv[${vatom}]}"
	MYSQL_VERSION_ID="${MYSQL_VERSION_ID}${tpv[${vatom}]:(-2)}"
done
# strip leading "0" (otherwise it's considered an octal number from bash)
MYSQL_VERSION_ID=${MYSQL_VERSION_ID##"0"}

# for future use ...
NDB_VERSION_ID=$(( ${MYSQL_VERSION_ID} / 100 ))

inherit mysql

DEPEND=">=sys-libs/readline-4.1
	bdb? ( sys-apps/ed )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	userland_GNU? ( sys-process/procps )
	>=sys-libs/zlib-1.2.3
	>=sys-apps/texinfo-4.7-r1
	>=sys-apps/sed-4"
RDEPEND="${DEPEND} selinux? ( sec-policy/selinux-mysql )"
# dev-perl/DBD-mysql is needed by some scripts installed by MySQL
PDEPEND="perl? ( >=dev-perl/DBD-mysql-2.9004 )"

src_test() {
	cd ${S}
	einfo ">>> Test phase [check]: ${CATEGORY}/${PF}"
	make check || die "make check failed"
	if ! useq minimal; then
		einfo ">>> Test phase [test]: ${CATEGORY}/${PF}"
		local retstatus
		addpredict /this-dir-does-not-exist/t9.MYI

		mysql_version_is_at_least "5.00.15.00" \
		&& make test-force-pl \
		|| make test
		retstatus=$?

		# to be sure ;)
		pkill -9 -f "${S}/ndb" 2>/dev/null
		pkill -9 -f "${S}/sql" 2>/dev/null
		[[ $retstatus -eq 0 ]] || die "make test failed"
	else
		einfo "Skipping server tests due to minimal build."
	fi
}
