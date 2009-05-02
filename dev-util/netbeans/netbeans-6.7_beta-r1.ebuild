# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/netbeans/netbeans-6.7_beta-r1.ebuild,v 1.2 2009/05/02 19:09:23 fordfrog Exp $

EAPI="2"
WANT_SPLIT_ANT="true"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="NetBeans IDE for Java"
HOMEPAGE="http://www.netbeans.org"

SLOT="6.7"
SRC_URI="http://download.netbeans.org/netbeans/6.7/beta/zip/netbeans-6.7beta-200904242137-src.zip
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-6.7-l10n-20090427163249.tar.bz2"

LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"

IUSE_NETBEANS_MODULES="
	+netbeans_modules_apisupport
	netbeans_modules_cnd
	netbeans_modules_dlight
	netbeans_modules_enterprise
	netbeans_modules_ergonomics
	netbeans_modules_groovy
	+netbeans_modules_harness
	+netbeans_modules_ide
	netbeans_modules_identity
	+netbeans_modules_java
	netbeans_modules_mobility
	+netbeans_modules_nb
	netbeans_modules_php
	netbeans_modules_profiler
	netbeans_modules_ruby
	netbeans_modules_webcommon
	+netbeans_modules_websvccommon"
IUSE_LINGUAS="
	linguas_cs
	linguas_de
	linguas_es
	linguas_fr
	linguas_it
	linguas_ja
	linguas_ko
	linguas_nl
	linguas_pl
	linguas_pt_BR
	linguas_ru
	linguas_sq
	linguas_tr
	linguas_zh_CN
	linguas_zh_TW"
IUSE="debug doc ${IUSE_NETBEANS_MODULES} ${IUSE_LINGUAS}"

RDEPEND=">=virtual/jdk-1.5
	java-virtuals/jdk-with-com-sun
	>=dev-java/javahelp-2:0
	dev-java/jsr223:0
	>=dev-java/junit-4:4
	>=dev-java/swing-layout-1:1
	netbeans_modules_enterprise? (
		>=dev-java/antlr-2.7.7:0[java]
		>=dev-java/asm-3.1:3
		dev-java/bsf:2.3
		dev-java/commons-beanutils:1.7
		dev-java/commons-collections:0
		dev-java/commons-digester:0
		>=dev-java/commons-fileupload-1:0
		>=dev-java/commons-io-1.1:1
		>=dev-java/commons-logging-1.1:0
		>=dev-java/commons-validator-1.3:0
		>=dev-java/httpunit-1.6:0
		dev-java/jakarta-jstl:0
		>=dev-java/jakarta-oro-2:2.0
		dev-java/jdom:1.0
		>=dev-java/jettison-1.0:0
		dev-java/jsr311-api:0
		>=dev-java/rome-0.9:0
	)
	netbeans_modules_ide? (
		>=dev-java/commons-codec-1.3:0
		>=dev-java/commons-httpclient-3.1:3
		>=dev-java/commons-lang-2.3:2.1
		>=dev-java/commons-logging-1.1:0
		>=dev-java/commons-net-1.4:0
		>=dev-java/flute-1.3:0
		>=dev-java/flyingsaucer-7:0
		>=dev-java/freemarker-2.3.8:2.3
		>=dev-java/jakarta-oro-2:2.0
		>=dev-java/jaxb-2:2
		>=dev-java/jdbc-mysql-5.1:0
		>=dev-java/jdbc-postgresql-8.3_p603:0
		dev-java/jsr173:0
		dev-java/lucene:2.4
		>=dev-java/sac-1.3:0
		dev-java/sun-jaf:0
		~dev-java/tomcat-servlet-api-3:2.2
		>=dev-java/xerces-2.8.1:2
		>=dev-util/subversion-1.6:0[java]
	)
	netbeans_modules_java? (
		>=dev-java/ant-1.7:0
		>=dev-java/antlr-2.7.7:0[java]
		dev-java/asm:2.2
		>=dev-java/beansbinding-1.2.1:0
		>=dev-java/cglib-2.2_beta:2.2
		dev-java/commons-collections:0
		>=dev-java/dom4j-1.6:1
		dev-java/ehcache:1.2
		dev-java/fastinfoset:0
		dev-java/glassfish-persistence:0
		dev-java/glassfish-transaction-api:0
		dev-java/hibernate:3.1
		dev-java/javassist:3
		>=dev-java/jdom-1.0:1.0
		dev-java/jsr181:0
		dev-java/jsr250:0
		dev-java/jsr67:0
		dev-java/jtidy:0
		>=dev-java/junit-3.8.2:0
		dev-java/saaj:0
		dev-java/sjsxp:0
		dev-java/stax-ex:0
		dev-java/xmlstreambuffer:0
	)
	netbeans_modules_mobility? (
		>=dev-java/ant-contrib-1.0_beta:0
		dev-java/bcprov:0
		>=dev-java/commons-codec-1.3:0
		dev-java/commons-httpclient:3
		dev-java/jakarta-slide-webdavclient:0
		dev-java/jdom:1.0
		>=dev-java/proguard-4.2:0
	)
	netbeans_modules_php? (
		dev-java/javacup
	)
	netbeans_modules_ruby? (
		dev-java/asm:3
		dev-java/bytelist:0
		dev-java/jline:0
		dev-java/joda-time:0
		dev-java/jruby:0
		dev-java/jvyamlb:0
	)"

DEPEND=">=virtual/jdk-1.5
	java-virtuals/jdk-with-com-sun
	app-arch/unzip
	>=dev-java/ant-core-1.7.1
	>=dev-java/ant-nodeps-1.7.1:0
	dev-java/ant-trax:0
	>=dev-java/javahelp-2:0
	dev-java/jsr223:0
	>=dev-java/junit-4:4
	>=dev-java/swing-layout-1:1
	netbeans_modules_enterprise? (
		>=dev-java/commons-fileupload-1:0
		>=dev-java/httpunit-1.6:0
		dev-java/jakarta-jstl:0
		dev-java/tomcat-servlet-api:2.3
	)
	netbeans_modules_ide? (
		>=dev-java/commons-codec-1.3:0
		>=dev-java/commons-httpclient-3.1:3
		>=dev-java/commons-lang-2.3:2.1
		>=dev-java/commons-logging-1.1:0
		>=dev-java/commons-net-1.4.1:0
		>=dev-java/flute-1.3:0
		>=dev-java/flyingsaucer-7:0
		>=dev-java/freemarker-2.3.8:2.3
		>=dev-java/jakarta-oro-2:2.0
		>=dev-java/javacc-3.2:0
		>=dev-java/jaxb-2.1:2
		>=dev-java/jdbc-mysql-5.1:0
		>=dev-java/jdbc-postgresql-8.3_p603:0
		dev-java/jsr173:0
		dev-java/lucene:2.4
		>=dev-java/sac-1.3:0
		dev-java/sun-jaf:0
		~dev-java/tomcat-servlet-api-3:2.2
		>=dev-java/xerces-2.8.1:2
		>=dev-util/subversion-1.6:0[java]
	)
	netbeans_modules_java? (
		dev-java/beansbinding:0
		>=dev-java/cglib-2.2_beta:2.2
		dev-java/jdom:1.0
		>=dev-java/junit-3.8:0
	)
	netbeans_modules_mobility? (
		>=dev-java/ant-contrib-1.0_beta:0
		dev-java/bcprov:0
		>=dev-java/commons-codec-1.3:0
		dev-java/commons-httpclient:3
		dev-java/jakarta-slide-webdavclient:0
		dev-java/jdom:1.0
		>=dev-java/proguard-4.2:0
	)
	netbeans_modules_php? (
		dev-java/javacup
	)
	netbeans_modules_ruby? (
		dev-java/bytelist:0
		dev-java/jvyamlb:0
	)"

S="${WORKDIR}"
BUILDDESTINATION="${S}/nbbuild/netbeans"
ENTERPRISE="5"
IDE_VERSION="11"
PLATFORM="10"
MY_FDIR="${FILESDIR}/${SLOT}"
DESTINATION="/usr/share/netbeans-${SLOT}"
JAVA_PKG_BSFIX="off"

pkg_setup() {
	local need_apisupport=""
	local need_dlight=""
	local need_enterprise=""
	local need_groovy=""
	local need_harness=""
	local need_ide=""
	local need_java=""
	local need_nb=""
	local need_profiler=""
	local need_webcommon=""
	local need_websvccommon=""

	# direct deps: harness, ide, java
	if use netbeans_modules_apisupport ; then
		need_harness="1"
		need_ide="1"
		need_java="1"
	fi

	# direct deps: dlight, ide
	if use netbeans_modules_cnd ; then
		need_dlight="1"
		need_ide="1"
	fi

	# direct deps: ide
	if use netbeans_modules_dlight ; then
		need_ide="1"
	fi

	# direct deps: ide, java, profiler, webcommon
	if use netbeans_modules_enterprise ; then
		need_ide="1"
		need_java="1"
		need_profiler="1"
		need_webcommon="1"
	fi

	# direct deps: ide
	if use netbeans_modules_ergonomics ; then
		need_ide="1"
	fi

	# direct deps: ide, java
	if use netbeans_modules_groovy ; then
		need_ide="1"
		need_java="1"
	fi

	# direct deps: enterprise, ide, java
	if use netbeans_modules_identity ; then
		need_enterprise="1"
		need_ide="1"
		need_java="1"
	fi

	# direct deps: ide, websvccommon
	if use netbeans_modules_java ; then
		need_ide="1"
		need_websvccommon="1"
	fi

	# direct deps: apisupport, enterprise, ide, java
	# dependency on enterprise cluster: http://www.netbeans.org/issues/show_bug.cgi?id=151535
	if use netbeans_modules_mobility ; then
		need_apisupport="1"
		need_enterprise="1"
		need_ide="1"
		need_java="1"
	fi

	# direct deps: harness, ide
	if use netbeans_modules_nb ; then
		need_harness="1"
		need_ide="1"
	fi

	# direct deps: ide, webcommon, websvccommon
	if use netbeans_modules_php ; then
		need_ide="1"
		need_webcommon="1"
		need_websvccommon="1"
	fi

	# direct deps: ide, java
	if use netbeans_modules_profiler ; then
		need_ide="1"
		need_java="1"
	fi

	# direct deps: ide, webcommon
	if use netbeans_modules_ruby ; then
		need_ide="1"
		need_webcommon="1"
	fi

	# direct deps: ide
	if use netbeans_modules_webcommon ; then
		need_ide="1"
	fi

	# direct deps: ide
	if use netbeans_modules_websvccommon ; then
		need_ide="1"
	fi

	if [ -n "${need_apisupport}" ] ; then
		need_harness="1"
		need_ide="1"
		need_java="1"
	fi

	if [ -n "${need_dlight}" ] ; then
		need_ide="1"
	fi

	if [ -n "${need_enterprise}" ] ; then
		need_ide="1"
		need_java="1"
		need_profiler="1"
		need_webcommon="1"
	fi

	if [ -n "${need_groovy}" ] ; then
		need_ide="1"
		need_java="1"
	fi

	if [ -n "${need_profiler}" ] ; then
		need_ide="1"
		need_java="1"
	fi

	if [ -n "${need_java}" ] ; then
		need_ide="1"
		need_websvccommon="1"
	fi

	if [ -n "${need_nb}" ] ; then
		need_harness="1"
		need_ide="1"
	fi

	if [ -n "${need_webcommon}" ] ; then
		need_ide="1"
	fi

	if [ -n "${need_websvccommon}" ] ; then
		need_ide="1"
	fi

	local missing=""
	[ -n "${need_apisupport}" ] && ! use netbeans_modules_apisupport && missing="${missing} apisupport"
	[ -n "${need_dlight}" ] && ! use netbeans_modules_dlight && missing="${missing} dlight"
	[ -n "${need_enterprise}" ] && ! use netbeans_modules_enterprise && missing="${missing} enterprise"
	[ -n "${need_groovy}" ] && ! use netbeans_modules_groovy && missing="${missing} groovy"
	[ -n "${need_harness}" ] && ! use netbeans_modules_harness && missing="${missing} harness"
	[ -n "${need_ide}" ] && ! use netbeans_modules_ide && missing="${missing} ide"
	[ -n "${need_java}" ] && ! use netbeans_modules_java && missing="${missing} java"
	[ -n "${need_nb}" ] && ! use netbeans_modules_nb && missing="${missing} nb"
	[ -n "${need_profiler}" ] && ! use netbeans_modules_profiler && missing="${missing} profiler"
	[ -n "${need_webcommon}" ] && ! use netbeans_modules_webcommon && missing="${missing} webcommon"
	[ -n "${need_websvccommon}" ] && ! use netbeans_modules_websvccommon && missing="${missing} websvccommon"

	if [ -n "${missing}" ] ; then
		eerror "You need to add these modules to NETBEANS_MODULES because they are needed by modules you have selected"
		eerror "   Missing NETBEANS_MODULES: ${missing}"
		die "Missing NETBEANS_MODULES"
	fi

	if ! use netbeans_modules_nb ; then
		ewarn "You are building netbeans without 'nb' module, this way you will build only specified"
		ewarn "clusters, not a functional IDE. In case you want functional IDE, add 'nb' to NETBEANS_MODULES."
		epause 5
	fi

	java-pkg-2_pkg_setup
}

src_prepare () {
	# We need to disable downloading of jars
	epatch "${FILESDIR}"/${SLOT}/nbbuild_build.xml.patch \
		"${FILESDIR}"/${SLOT}/nbbuild_templates_projectized.xml.patch

	# Clean up nbbuild
	einfo "Removing prebuilt *.class files from nbbuild"
	find "${S}" -name "*.class" | xargs rm -v

	if [ -z "${JAVA_PKG_NB_USE_BUNDLED}" ] ; then
		place_unpack_symlinks
	fi

	if [ -z "${JAVA_PKG_NB_KEEP_BUNDLED}" ] ; then
		# We do not remove the jars that we ar not able to unbundle atm
		# More info at: https://overlays.gentoo.org/proj/java/wiki/Netbeans_Maintenance

		local tmpfile="${T}/bundled.txt"

		einfo "Removing rest of the bundled jars..."
		find "${S}" -type f -name "*.jar" > ${tmpfile} || die "Cannot put jars in tmp file"

		sed -e "/libs\.jna\/external\/jna-3\.0\.9\.jar/d" -i ${tmpfile} || die

		if use netbeans_modules_dlight ; then
			sed -e "/dlight\.db\.h2\/external\/h2-1\.0\.79\.jar/d" -i ${tmpfile} || die
			sed -e "/dlight\.derby\.support\/external\/derby-10\.2\.2\.0\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_enterprise ; then
			sed -e "/j2eeapis\/external\/jsr88javax\.jar/d" -i ${tmpfile} || die
			sed -e "/j2ee\.sun\.appsrv81\/external\/appservapis-2\.0\.58\.3\.jar/d" -i ${tmpfile} || die
			sed -e "/j2ee\.sun\.appsrv81\/external\/org-netbeans-modules-j2ee-sun-appsrv81\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.glassfish_logging\/external\/glassfish-logging-2\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/servletjspapi\/external\/servlet2\.5-jsp2\.1-api\.jar/d" -i ${tmpfile} || die
			sed -e "/spring\.webmvc\/external\/spring-webmvc-2\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/web\.jsf\/external\/shale-remoting-1\.0\.4\.jar/d" -i ${tmpfile} || die
			sed -e "/web\.jspparser\/external\/glassfish-jspparser-2\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/websvc\.restlib\/external\/jersey-api-doc\.jar/d" -i ${tmpfile} || die
			sed -e "/websvc\.restlib\/external\/jsr311-api-doc\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_groovy ; then
			sed -e "/groovy\.editor\/external\/groovy-all-1\.5\.7\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_harness ; then
			sed -e "/apisupport\.harness\/external\/openjdk-javac-6-b12\.jar/d" -i ${tmpfile} || die
			sed -e "/jemmy\/external\/jemmy-2\.3\.0\.0\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_ide ; then
			sed -e "/httpserver\/external\/tomcat-webserver-3\.2\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.bugtracking\/external\/org\.eclipse\.mylyn\.commons\.core_3\.0\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.bugtracking\/external\/org\.eclipse\.mylyn\.commons\.net_3\.0\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.bugtracking\/external\/org\.eclipse\.mylyn\.tasks\.core_3\.0\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.bugzilla\/external\/org\.eclipse\.mylyn\.bugzilla\.core_3\.0\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.ini4j\/external\/ini4j-0\.4\.1\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.svnClientAdapter\/external\/svnClientAdapter-1\.6\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.swingx\/external\/swingx-0\.9\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.smack\/external\/smack\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.smack\/external\/smackx\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.jaxb\/external\/jaxb-impl\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.jaxb\/external\/jaxb-xjc\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.jsch\/external\/jsch-0\.1\.39\.jar/d" -i ${tmpfile} || die
			sed -e "/o\.apache\.xml\.resolver\/external\/resolver-1\.2\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_java ; then
			sed -e "/j2ee\.toplinklib\/external\/glassfish-persistence-v2ur1-build-09d\.jar/d" -i ${tmpfile} || die
			sed -e "/junit\/external\/Ant-1\.7\.1-binary-patch-72080\.jar/d" -i ${tmpfile} || die
			sed -e "/junit\/external\/junit-4\.5-src\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.javacapi\/external\/javac-api-nb-7\.0-b07\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.javacimpl\/external\/javac-impl-nb-7\.0-b07\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.springframework\/external\/spring-2\.5\.jar/d" -i ${tmpfile} || die
			sed -e "/maven\.embedder\/external\/maven-dependency-tree-1\.2\.jar/d" -it ${tmpfile} || die
			sed -e "/maven\.embedder\/external\/maven-embedder-2\.1-20080623-patched\.jar/d" -i ${tmpfile} || die
			sed -e "/maven\.indexer\/external\/nexus-indexer-1\.2\.2-shaded\.jar/d" -i ${tmpfile} || die
			sed -e "/swingapp\/external\/appframework-1\.0\.3\.jar/d" -i ${tmpfile} || die
			sed -e "/swingapp\/external\/swing-worker-1\.1\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_mobility ; then
			sed -e "/j2me\.cdc\.project\.bdj\/external\/bdjo\.jar/d" -i ${tmpfile} || die
			sed -e "/j2me\.cdc\.project\.bdj\/external\/security\.jar/d" -i ${tmpfile} || die
			sed -e "/j2me\.cdc\.project\.ricoh\/external\/RicohAntTasks-2\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.databindingme\/lib\/netbeans_databindingme\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.databindingme\/lib\/netbeans_databindingme_pim\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.databindingme\/lib\/netbeans_databindingme_svg\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.deployment\.webdav\/external\/jakarta-slide-ant-webdav-2\.1\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.j2meunit\/external\/jmunit4cldc10-1\.2\.1\.jar/d" -i ${tmpfile} || die
			sed -e "/mobility\.j2meunit\/external\/jmunit4cldc11-1\.2\.1\.jar/d" -i ${tmpfile} || die
			sed -e "/o\.n\.mobility\.lib\.activesync\/external\/nbactivesync-5\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/svg\.perseus\/external\/perseus-nb-1\.0\.jar/d" -i ${tmpfile} || die
			sed -e "/vmd\.components\.midp\/netbeans_midp_components_basic\/dist\/netbeans_midp_components_basic\.jar/d" -i ${tmpfile} || die
			sed -e "/vmd\.components\.midp\.pda\/netbeans_midp_components_pda\/dist\/netbeans_midp_components_pda\.jar/d" -i ${tmpfile} || die
			sed -e "/vmd\.components\.midp\.wma\/netbeans_midp_components_wma\/dist\/netbeans_midp_components_wma\.jar/d" -i ${tmpfile} || die
			sed -e "/vmd\.components\.svg\/nb_svg_midp_components\/dist\/nb_svg_midp_components\.jar/d" -i ${tmpfile} || die
		fi

		if use netbeans_modules_ruby ; then
			sed -e "/libs\.jrubyparser\/external\/jruby-parser-0\.1\.jar/d" -i ${tmpfile} || die
			sed -e "/libs\.yydebug\/external\/yydebug-1\.0\.2\.jar/d" -i ${tmpfile} || die
			sed -e "\/o\.kxml2\/external\/kxml2-2\.3\.0\.jar/d" -i ${tmpfile} || die
			sed -e "\/o\.rubyforge\.debugcommons\/external\/debug-commons-java-0\.10\.0\.jar/d" -i ${tmpfile} || die
		fi

		for file in `cat ${tmpfile}` ; do
			rm -v ${file}
		done
	fi
}

src_compile() {
	local antflags="-Dstop.when.broken.modules=true -Dpermit.jdk6.builds=true"

	if use debug; then
		antflags="${antflags} -Dbuild.compiler.debug=true"
		antflags="${antflags} -Dbuild.compiler.deprecation=true"
	else
		antflags="${antflags} -Dbuild.compiler.deprecation=false"
	fi

	local clusters="-Dnb.clusters.list=nb.cluster.platform"
	for netbeans_module in ${IUSE_NETBEANS_MODULES} ; do
		netbeans_module=${netbeans_module/[+]/}
		local short_netbeans_module=${netbeans_module/netbeans_modules_/}
		use ${netbeans_module} && clusters="${clusters},nb.cluster.${short_netbeans_module}"
	done

	local build_target=""
	if use netbeans_modules_nb ; then
		build_target="build-nozip"
	else
		build_target="build-clusters"
		mkdir -p "${BUILDDESTINATION}" || die
	fi

	# Fails to compile
	java-pkg_filter-compiler ecj-3.2 ecj-3.3 ecj-3.4

	# Build the clusters
	ANT_TASKS="ant-nodeps ant-trax"
	ANT_OPTS="-Xmx1g -Djava.awt.headless=true" eant ${antflags} ${clusters} -f nbbuild/build.xml ${build_target}

	local locales=""
	for lang in ${IUSE_LINGUAS} ; do
		local mylang=${lang/linguas_/}
		if use ${lang} ; then
			if [ -z "${locales}" ] ; then
				locales="${mylang}"
			else
				locales="${locales},${mylang}"
			fi
		fi
	done

	if [ -n "${locales}" ] ; then
		einfo "Compiling support for locales: ${locales}"
		eant ${antflags} -Dlocales=${locales} -Ddist.dir=../nbbuild/netbeans -Dnbms.dir="" -Dnbms.dist.dir="" \
			-f l10n/build.xml build
	fi

	# Running build-javadoc from the same command line as build-nozip doesn't work
	# so we must run it separately
	if use doc ; then
		ANT_TASKS="ant-nodeps ant-trax" ANT_OPTS="-Xmx1g" eant ${antflags} ${clusters} -f nbbuild/build.xml build-javadoc
	fi

	# Remove non-Linux binaries
	einfo "Removing libraries and scripts for non-linux archs..."
	find "${BUILDDESTINATION}" -type f \
		-name "*.exe" -o \
		-name "*.cmd" -o \
		-name "*.bat" -o \
		-name "*.dll"	  \
		| grep -v "/profiler3/" | xargs rm -fv

	if use netbeans_modules_cnd ; then
		rm -fv "${BUILDDESTINATION}"/cnd2/bin/*-SunOS-*
		rm -fv "${BUILDDESTINATION}"/cnd2/bin/*-Mac_OS_X-*
	fi

	# Removing external stuff. They are api docs from external libs.
	rm -f "${BUILDDESTINATION}"/ide${IDE_VERSION}/docs/*.zip

	# Remove zip files from generated javadocs.
	rm -f "${BUILDDESTINATION}"/javadoc/*.zip

	# Use the system ant
	if use netbeans_modules_java ; then
		cd "${BUILDDESTINATION}"/java2/ant || die "Cannot cd to "${BUILDDESTINATION}"/java2/ant"
		rm -fr lib
		rm -fr bin
	fi

	# Set initial default jdk
	if [[ -e "${BUILDDESTINATION}"/etc/netbeans.conf ]]; then
		echo "netbeans_jdkhome=\"\$(java-config -O)\"" >> "${BUILDDESTINATION}"/etc/netbeans.conf
	fi

	# Install Gentoo Netbeans ID
	# This ID is used to identify our netbeans package while contacting update center
	mkdir -p  "${BUILDDESTINATION}"/nb${SLOT}/config || die
	echo "NBGNT" > "${BUILDDESTINATION}"/nb${SLOT}/config/productid || die "Could not set Gentoo Netbeans ID"

	# fix paths per bug# 163483
	if [[ -e "${BUILDDESTINATION}"/bin/netbeans ]]; then
		sed -i -e 's:"$progdir"/../etc/:/etc/netbeans-6.7/:' "${BUILDDESTINATION}"/bin/netbeans
		sed -i -e 's:"${userdir}"/etc/:/etc/netbeans-6.7/:' "${BUILDDESTINATION}"/bin/netbeans
	fi
}

src_install() {
	insinto ${DESTINATION}

	einfo "Installing the program..."
	cd "${BUILDDESTINATION}"
	doins -r *

	# Remove the build helper files
	rm -f "${D}"/${DESTINATION}/nb.cluster.*
	rm -f "${D}"/${DESTINATION}/*.built
	rm -f "${D}"/${DESTINATION}/moduleCluster.properties
	rm -f "${D}"/${DESTINATION}/module_tracking.xml
	rm -f "${D}"/${DESTINATION}/build_info

	# Change location of etc files
	if [[ -e "${BUILDDESTINATION}"/etc ]]; then
		insinto /etc/${PN}-${SLOT}
		doins "${BUILDDESTINATION}"/etc/*
		rm -fr "${D}"/${DESTINATION}/etc
		dosym /etc/${PN}-${SLOT} ${DESTINATION}/etc
	fi

	# Replace bundled jars with system jars
	if [ -z "${JAVA_PKG_NB_USE_BUNDLED}" ] ; then
		symlink_extjars
	fi

	# Correct permissions on executables and possibly remove executables that are not needed on linux
	local nbexec_exe="${DESTINATION}/platform${PLATFORM}/lib/nbexec"
	fperms 775 ${nbexec_exe} || die
	if [[ -e "${D}"/${DESTINATION}/bin/netbeans ]] ; then
		fperms 755 "${DESTINATION}/bin/netbeans" || die
	fi
	if use netbeans_modules_cnd ; then
		cd "${D}"/${DESTINATION}/cnd2/bin || die
		for file in *.sh ; do
			fperms 755 ${file} || die
		done
	fi
	if use netbeans_modules_profiler ; then
		cd "${D}"/${DESTINATION}/profiler3/remote-pack-defs || die
		for file in *.sh ; do
			fperms 755 ${file} || die
		done
	fi
	if use netbeans_modules_ruby ; then
		cd "${D}"/${DESTINATION}/ruby2/jruby-1.2.0/bin || die
		for file in * ; do
			fperms 755 ${file} || die
		done
	fi

	# Link netbeans executable from bin
	if [[ -f "${D}"/${DESTINATION}/bin/netbeans ]]; then
		dosym ${DESTINATION}/bin/netbeans /usr/bin/${PN}-${SLOT}
	else
		dosym ${DESTINATION}/platform7/lib/nbexec /usr/bin/${PN}-${SLOT}
	fi

	# Ant installation
	if use netbeans_modules_java ; then
		local ANTDIR="${DESTINATION}/java2/ant"
		dosym /usr/share/ant/lib ${ANTDIR}/lib
		dosym /usr/share/ant-core/bin ${ANTDIR}/bin
	fi

	# Documentation
	einfo "Installing Documentation..."

	cd "${D}"/${DESTINATION}
	dohtml CREDITS.html README.html netbeans.css
	rm -f build_info CREDITS.html README.html netbeans.css

	use doc && java-pkg_dojavadoc "${S}"/nbbuild/build/javadoc

	# Icons and shortcuts
	if use netbeans_modules_nb ; then
		einfo "Installing icon..."
		dodir /usr/share/icons/hicolor/32x32/apps
		dosym ${DESTINATION}/nb${SLOT}/netbeans.png /usr/share/icons/hicolor/32x32/apps/netbeans-${SLOT}.png
	fi

	make_desktop_entry netbeans-${SLOT} "Netbeans ${SLOT}" netbeans-${SLOT}.png Development
}

pkg_postinst() {
	if use netbeans_modules_nb ; then
		einfo "If you want to use specific locale of netbeans, use --locale argument, for example:"
		einfo "${PN}-${SLOT} --locale de"
		einfo "${PN}-${SLOT} --locale pt:BR"
	fi
}

# Supporting functions for this ebuild

place_unpack_symlinks() {
	local target=""

	einfo "Symlinking compilation-time jars"

	dosymcompilejar "javahelp/external" javahelp jh.jar jh-2.0_05.jar
	dosymcompilejar "apisupport.harness/external" javahelp jhall.jar jsearch-2.0_05.jar
	dosymcompilejar "o.jdesktop.layout/external" swing-layout-1 swing-layout.jar swing-layout-1.0.3.jar
	dosymcompilejar "libs.jsr223/external" jsr223 script-api.jar jsr223-api.jar
	dosymcompilejar "libs.junit4/external" junit-4 junit.jar junit-4.5.jar

	if use netbeans_modules_enterprise ; then
		dosymcompilejar "libs.commons_fileupload/external" commons-fileupload commons-fileupload.jar commons-fileupload-1.0.jar
		dosymcompilejar "libs.httpunit/external" httpunit httpunit.jar httpunit-1.6.2.jar
		dosymcompilejar "web.jstl11/external" jakarta-jstl jstl.jar jstl-1.1.2.jar
		dosymcompilejar "web.jstl11/external" jakarta-jstl standard.jar standard-1.1.2.jar
		dosymcompilejar "web.monitor/external" tomcat-servlet-api-2.3 servlet.jar servlet-2.3.jar
	fi

	if use netbeans_modules_ide ; then
		dosymcompilejar "libs.commons_codec/external" commons-codec commons-codec.jar apache-commons-codec-1.3.jar
		dosymcompilejar "libs.commons_logging/external" commons-logging commons-logging.jar commons-logging-1.1.jar
		dosymcompilejar "libs.bugtracking/external" commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.1.jar
		dosymcompilejar "libs.bugtracking/external" commons-lang-2.1 commons-lang.jar commons-lang-2.3.jar
		dosymcompilejar "libs.svnClientAdapter/external" subversion svn-javahl.jar svnjavahl-1.6.0.jar
		dosymcompilejar "libs.lucene/external" lucene-2.4 lucene-core.jar lucene-core-2.3.2.jar
		dosymcompilejar "web.flyingsaucer/external" flyingsaucer core-renderer.jar core-renderer-R7final.jar
		dosymcompilejar "css.visual/external" sac sac.jar sac-1.3.jar
		dosymcompilejar "css.visual/external" flute flute.jar flute-1.3.jar
		dosymcompilejar "db.drivers/external" jdbc-mysql jdbc-mysql.jar mysql-connector-java-5.1.6-bin.jar
		dosymcompilejar "db.drivers/external" jdbc-postgresql jdbc-postgresql.jar postgresql-8.3-603.jdbc3.jar
		dosymcompilejar "db.sql.visualeditor/external" javacc javacc.jar javacc-3.2.jar
		dosymcompilejar "servletapi/external" tomcat-servlet-api-2.2 servlet.jar servlet-2.2.jar
		dosymcompilejar "libs.xerces/external" xerces-2 xercesImpl.jar xerces-2.8.0.jar
		dosymcompilejar "libs.jakarta_oro/external" jakarta-oro-2.0 jakarta-oro.jar jakarta-oro-2.0.8.jar
		dosymcompilejar "libs.commons_net/external" commons-net commons-net.jar commons-net-1.4.1.jar
		dosymcompilejar "libs.freemarker/external" freemarker-2.3 freemarker.jar freemarker-2.3.8.jar
		dosymcompilejar "libs.jaxb/external" jaxb-2 jaxb-api.jar jaxb-api.jar
		dosymcompilejar "libs.jaxb/external" jsr173 jsr173.jar jsr173_api.jar
		dosymcompilejar "libs.jaxb/external" sun-jaf activation.jar activation.jar
	fi

	if use netbeans_modules_java ; then
		dosymcompilejar "o.jdesktop.beansbinding/external" beansbinding beansbinding.jar beansbinding-1.2.1.jar
		dosymcompilejar "maven.embedder/external" jdom-1.0 jdom.jar jdom-1.0.jar
		dosymcompilejar "junit/external" junit junit.jar junit-3.8.2.jar
		dosymcompilejar "libs.cglib/external" cglib-2.2 cglib.jar cglib-2.2.jar
	fi

	if use netbeans_modules_mobility ; then
		dosymcompilejar "j2me.cdc.project.bdj/external" bcprov bcprov.jar bcprov-jdk15-139.jar
		dosymcompilejar "j2me.cdc.project.ricoh/external" commons-codec commons-codec.jar commons-codec-1.3.jar
		dosymcompilejar "j2me.cdc.project.ricoh/external" commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.0.jar
		dosymcompilejar "mobility.antext/external" ant-contrib ant-contrib.jar ant-contrib-1.0b3.jar
		dosymcompilejar "mobility.deployment.webdav/external" commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.0.1.jar
		dosymcompilejar "mobility.deployment.webdav/external" jdom-1.0 jdom.jar jdom-1.0.jar
		dosymcompilejar "mobility.deployment.webdav/external" jakarta-slide-webdavclient jakarta-slide-webdavlib.jar jakarta-slide-webdavlib-2.1.jar
		dosymcompilejar "mobility.proguard/external" proguard proguard.jar proguard4.2.jar
	fi

	if use netbeans_modules_php ; then
		dosymcompilejar "libs.javacup/external" javacup javacup.jar java-cup-11a.jar
	fi

	if use netbeans_modules_ruby ; then
		dosymcompilejar "libs.bytelist/external" bytelist bytelist.jar bytelist-0.1.jar
		dosymcompilejar "libs.jvyamlb/external" jvyamlb jvyamlb.jar jvyamlb-0.2.3.jar
	fi

	if [ -n "${NB_DOSYMCOMPILEJARFAILED}" ] ; then
		die "Some compilation-time jars could not be symlinked"
	fi
}

symlink_extjars() {
	local targetdir=""

	einfo "Symlinking runtime jars"

	targetdir="platform${PLATFORM}/modules/ext"
	dosyminstjar ${targetdir} javahelp jh.jar jh-2.0_05.jar
	# jna-3.0.2.jar
	dosyminstjar ${targetdir} jsr223 script-api.jar script-api.jar
	dosyminstjar ${targetdir} junit-4 junit.jar junit-4.5.jar
	dosyminstjar ${targetdir} swing-layout-1 swing-layout.jar swing-layout-1.0.3.jar

	if use netbeans_modules_dlight ; then
		targetdir="dlight1/modules/ext"
		# derby-10.2.2.0.jar
		# h2-1.0.79.jar
	fi

	if use netbeans_modules_enterprise ; then
		targetdir="/enterprise5/modules/ext"
		dosyminstjar ${targetdir} commons-fileupload commons-fileupload.jar commons-fileupload-1.0.jar
		# glassfish-jspparser-2.0.jar
		# glassfish-logging-2.0.jar
		dosyminstjar ${targetdir} httpunit httpunit.jar httpunit-1.6.2.jar
		dosyminstjar ${targetdir} jakarta-jstl jstl.jar jstl.jar
		dosyminstjar ${targetdir} jakarta-jstl standard.jar standard.jar
		# jsr88javax.jar
		# servlet2.5-jsp2.1-api.jar
		# shale-remoting-1.0.4.jar
		targetdir="enterprise5/modules/ext/spring"
		# spring-webmvc-2.5.jar
		targetdir="enterprise5/modules/ext/jsf-1_2"
		dosyminstjar ${targetdir} commons-beanutils-1.7 commons-beanutils.jar commons-beanutils.jar
		dosyminstjar ${targetdir} commons-collections commons-collections.jar commons-collections.jar
		dosyminstjar ${targetdir} commons-digester commons-digester.jar commons-digester.jar
		dosyminstjar ${targetdir} commons-logging commons-logging.jar commons-logging.jar
		# jsf-api.jar
		# jsf-impl.jar
		targetdir="enterprise5/modules/ext/struts"
		dosyminstjar ${targetdir} antlr antlr.jar antlr-2.7.2.jar
		dosyminstjar ${targetdir} bsf-2.3 bsf.jar bsf-2.3.0.jar
		dosyminstjar ${targetdir} commons-beanutils-1.7 commons-beanutils.jar commons-beanutils-1.7.0.jar
		# commons-chain-1.1.jar
		dosyminstjar ${targetdir} commons-digester commons-digester.jar commons-digester-1.8.jar
		dosyminstjar ${targetdir} commons-fileupload commons-fileupload.jar commons-fileupload-1.1.1.jar
		dosyminstjar ${targetdir} commons-io-1 commons-io.jar commons-io-1.1.jar
		dosyminstjar ${targetdir} commons-logging commons-logging.jar commons-logging-1.0.4.jar
		dosyminstjar ${targetdir} commons-validator commons-validator.jar commons-validator-1.3.1.jar
		dosyminstjar ${targetdir} jakarta-jstl jstl.jar jstl-1.0.2.jar
		dosyminstjar ${targetdir} jakarta-jstl standard.jar standard-1.0.2.jar
		dosyminstjar ${targetdir} jakarta-oro-2.0 jakarta-oro.jar oro-2.0.8.jar
		# struts-core-1.3.8.jar
		# struts-el-1.3.8.jar
		# struts-extras-1.3.8.jar
		# struts-faces-1.3.8.jar
		# struts-mailreader-dao-1.3.8.jar
		# struts-scripting-1.3.8.jar
		# struts-taglib-1.3.8.jar
		# struts-tiles-1.3.8.jar
		targetdir="enterprise5/modules/ext/metro"
		# webservices-api.jar
		# webservices-extra.jar
		# webservices-extra-api.jar
		# webservices-rt.jar
		# webservices-tools.jar
		targetdir="/enterprise5/modules/ext/rest"
		dosyminstjar ${targetdir} asm-3 asm.jar asm-3.1.jar
		# grizzly-servlet-webserver-1.7.3.2.jar
		# http.jar
		dosyminstjar ${targetdir} jdom-1.0 jdom.jar jdom-1.0.jar
		# jersey.jar
		# jersey-spring.jar
		dosyminstjar ${targetdir} jettison jettison.jar jettison-1.0-RC1.jar
		dosyminstjar ${targetdir} jsr311-api jsr311-api.jar jsr311-api.jar
		dosyminstjar ${targetdir} rome rome.jar rome-0.9.jar
		# wadl2java.jar
	fi

	# if use netbeans_modules_groovy ; then
		# groovy-all.jar
	# fi

	if use netbeans_modules_harness ; then
		targetdir="harness/antlib"
		dosyminstjar ${targetdir} javahelp jhall.jar jsearch-2.0_05.jar
		# openjdk-javac-6-b12.jar
	fi

	if use netbeans_modules_ide ; then
		targetdir="ide${IDE_VERSION}/modules/ext"
		dosyminstjar ${targetdir} commons-codec commons-codec.jar apache-commons-codec-1.3.jar
		dosyminstjar ${targetdir} commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.1.jar
		dosyminstjar ${targetdir} commons-lang-2.1 commons-lang.jar commons-lang-2.3.jar
		dosyminstjar ${targetdir} commons-logging commons-logging.jar commons-logging-1.1.jar
		dosyminstjar ${targetdir} commons-net commons-net.jar commons-net-1.4.1.jar
		dosyminstjar ${targetdir} flute flute.jar flute-1.3.jar
		dosyminstjar ${targetdir} flyingsaucer core-renderer.jar core-renderer.jar
		dosyminstjar ${targetdir} freemarker-2.3 freemarker.jar freemarker-2.3.8.jar
		# ini4j-0.4.1.jar
		dosyminstjar ${targetdir} jakarta-oro-2.0 jakarta-oro.jar jakarta-oro-2.0.8.jar
		dosyminstjar ${targetdir} jdbc-mysql jdbc-mysql.jar mysql-connector-java-5.1.6-bin.jar
		dosyminstjar ${targetdir} jdbc-postgresql jdbc-postgresql.jar postgresql-8.3-603.jdbc3.jar
		# jsch-0.1.39.jar
		dosyminstjar ${targetdir} lucene-2.4 lucene-core.jar lucene-core-2.3.2.jar
		# org.eclipse.mylyn.bugzilla.core_3.0.5.jar
		# org.eclipse.mylyn.commons.core_3.0.5.jar
		# org.eclipse.mylyn.commons.net_3.0.5.jar
		# org.eclipse.mylyn.tasks.core_3.0.5.jar
		# org-mozilla-rhino-patched.jar
		dosyminstjar ${targetdir} sac sac.jar sac-1.3.jar
		# smack.jar
		# smackx.jar
		# resolver-1.2.jar
		# svnClientAdapter-1.6.0.jar
		dosyminstjar ${targetdir} subversion svn-javahl.jar svnjavahl-1.6.0.jar
		# swingx-0.9.5.jar
		dosyminstjar ${targetdir} tomcat-servlet-api-2.2 servlet.jar servlet-2.2.jar
		# webserver.jar
		dosyminstjar ${targetdir} xerces-2 xercesImpl.jar xerces-2.8.0.jar
		targetdir="ide${IDE_VERSION}/modules/ext/jaxb"
		dosyminstjar ${targetdir} sun-jaf activation.jar activation.jar
		# jaxb-impl.jar
		# jaxb-xjc.jar
		targetdir="ide${IDE_VERSION}/modules/ext/jaxb/api"
		dosyminstjar ${targetdir} jaxb-2 jaxb-api.jar jaxb-api.jar
		dosyminstjar ${targetdir} jsr173 jsr173.jar jsr173_api.jar
	fi

	if use netbeans_modules_java ; then
		targetdir="java2/ant/etc"
		dosyminstjar ${targetdir} ant ant-bootstrap.jar ant-bootstrap.jar
		targetdir="java2/ant/nblib"
		# bridge.jar
		targetdir="java2/ant/patches"
		# 72080.jar
		targetdir="java2/modules"
		# org-apache-tools-ant-module.jar
		targetdir="java2/modules/ext"
		# appframework-1.0.3.jar
		dosyminstjar ${targetdir} beansbinding beansbinding.jar beansbinding-1.2.1.jar
		dosyminstjar ${targetdir} cglib-2.2 cglib.jar cglib-2.2.jar
		# javac-api-nb-7.0-b07.jar
		# javac-impl-nb-7.0-b07.jar
		dosyminstjar ${targetdir} jdom-1.0 jdom.jar jdom-1.0.jar
		# maven-dependency-tree-1.2.jar
		# maven-embedder-2.1-20080623-patched.jar
		# nexus-indexer-1.2.2-shaded.jar
		dosyminstjar ${targetdir} junit junit.jar junit-3.8.2.jar
		# swing-worker-1.1.jar
		targetdir="java2/modules/ext/jaxws21"
		dosyminstjar ${targetdir} fastinfoset fastinfoset.jar FastInfoset.jar
		# http.jar
		# jaxws-rt.jar
		# jaxws-tools.jar
		# mimepull.jar
		dosyminstjar ${targetdir} saaj saaj.jar saaj-impl.jar
		dosyminstjar ${targetdir} sjsxp sjsxp.jar sjsxp.jar
		dosyminstjar ${targetdir} stax-ex stax-ex.jar stax-ex.jar
		dosyminstjar ${targetdir} xmlstreambuffer streambuffer.jar streambuffer.jar
		targetdir="java2/modules/ext/jaxws21/api"
		# jaxws-api.jar
		dosyminstjar ${targetdir} jsr250 jsr250.jar jsr250-api.jar
		dosyminstjar ${targetdir} jsr67 jsr67.jar saaj-api.jar
		dosyminstjar ${targetdir} jsr181 jsr181.jar jsr181-api.jar
		targetdir="java2/modules/ext/hibernate"
		dosyminstjar ${targetdir} antlr antlr.jar antlr-2.7.6.jar
		dosyminstjar ${targetdir} asm-2.2 asm.jar asm.jar
		dosyminstjar ${targetdir} asm-2.2 asm-attrs.jar asm-attrs.jar
		dosyminstjar ${targetdir} cglib-2.2 cglib.jar cglib-2.1.3.jar
		dosyminstjar ${targetdir} commons-collections commons-collections.jar commons-collections-2.1.1.jar
		dosyminstjar ${targetdir} dom4j-1 dom4j.jar dom4j-1.6.1.jar
		dosyminstjar ${targetdir} ehcache-1.2 ehcache.jar ehcache-1.2.3.jar
		dosyminstjar ${targetdir} glassfish-persistence glassfish-persistence.jar ejb3-persistence.jar
		dosyminstjar ${targetdir} glassfish-transaction-api jta.jar jta.jar
		dosyminstjar ${targetdir} hibernate-3.1 hibernate3.jar hibernate3.jar
		# hibernate-annotations.jar
		# hibernate-commons-annotations.jar
		# hibernate-entitymanager.jar
		# hibernate-tools.jar
		dosyminstjar ${targetdir} javassist-3 javassist.jar javassist.jar
		# jdbc2_0-stdext.jar
		dosyminstjar ${targetdir} jtidy Tidy.jar jtidy-r8-20060801.jar
		targetdir="java2/modules/ext/spring"
		# spring-2.5.jar
		targetdir="java2/modules/ext/toplink"
		# toplink-essentials.jar
		# toplink-essentials-agent.jar
	fi

	if use netbeans_modules_mobility ; then
		targetdir="mobility8/modules/ext"
		dosyminstjar ${targetdir} ant-contrib ant-contrib.jar ant-contrib-1.0b3.jar
		dosyminstjar ${targetdir} bcprov bcprov.jar bcprov-jdk15-139.jar
		# bdjo.jar
		# cdc-agui-swing-layout.jar
		# cdc-pp-awt-layout.jar
		dosyminstjar ${targetdir} commons-codec commons-codec.jar commons-codec-1.3.jar
		dosyminstjar ${targetdir} commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.0.jar
		dosyminstjar ${targetdir} commons-httpclient-3 commons-httpclient.jar commons-httpclient-3.0.1.jar
		dosyminstjar ${targetdir} jakarta-slide-webdavclient jakarta-slide-webdavlib.jar jakarta-slide-webdavlib-2.1.jar
		# jakarta-slide-ant-webdav-2.1.jar
		dosyminstjar ${targetdir} jdom-1.0 jdom.jar jdom-1.0.jar
		# jmunit4cldc10-1.2.1.jar
		# jmunit4cldc11-1.2.1.jar
		# perseus-nb-1.0.jar
		# RicohAntTasks-2.0.jar
		# security.jar
		targetdir="mobility8/external/proguard"
		dosyminstjar ${targetdir} proguard proguard.jar proguard4.2.jar
	fi

	if use netbeans_modules_php ; then
		targetdir="php1/modules/ext"
		dosyminstjar ${targetdir} javacup javacup.jar java-cup-11a.jar
	fi

	if use netbeans_modules_ruby ; then
		targetdir="ruby2/modules/ext"
		dosyminstjar ${targetdir} asm-3 asm.jar asm-3.0.jar
		dosyminstjar ${targetdir} asm-3 asm-analysis.jar asm-analysis-3.0.jar
		dosyminstjar ${targetdir} asm-3 asm-commons.jar asm-commons-3.0.jar
		dosyminstjar ${targetdir} asm-3 asm-tree.jar asm-tree-3.0.jar
		dosyminstjar ${targetdir} asm-3 asm-util.jar asm-util-3.0.jar
		dosyminstjar ${targetdir} bytelist bytelist.jar bytelist-0.1.jar
		# debug-commons-java-0.10.0.jar
		# dynalang-0.3.jar
		dosyminstjar ${targetdir} jline jline.jar jline-0.9.93.jar
		# jna-posix.jar
		dosyminstjar ${targetdir} joda-time joda-time.jar joda-time-1.5.1.jar
		# joni.jar
		# jruby-parser-0.1.jar
		dosyminstjar ${targetdir} jvyamlb jvyamlb jvyamlb-0.2.3.jar
		# kxml2-2.3.0.jar
		# yydebug-1.0.2.jar
	fi

	if [ -n "${NB_DOSYMINSTJARFAILED}" ] ; then
		die "Some runtime jars could not be symlinked"
	fi
}

dosymcompilejar() {
	if [ -z "${JAVA_PKG_NB_BUNDLED}" ] ; then
		local dest="${1}"
		local package="${2}"
		local jar_file="${3}"
		local target_file="${4}"

		# We want to know whether the target jar exists and fail if it doesn't so we know
		# something is wrong
		local target="${S}/${dest}/${target_file}"
		if [ -e "${target}" ] ; then
			java-pkg_jar-from --build-only --into "${S}"/${dest} ${package} ${jar_file} ${target_file}
		else
			ewarn "Target jar does not exist so will not create link: ${target}"
			NB_DOSYMCOMPILEJARFAILED="1"
		fi
	fi
}

dosyminstjar() {
	if [ -z "${JAVA_PKG_NB_BUNDLED}" ] ; then
		local dest="${1}"
		local package="${2}"
		local jar_file="${3}"
		local target_file=""
		if [ -z "${4}" ]; then
			target_file="${3}"
		else
			target_file="${4}"
		fi

		# We want to know whether the target jar exists and fail if it doesn't so we know
		# something is wrong
		local target="${DESTINATION}/${dest}/${target_file}"
		if [ -e "${D}/${target}" ] ; then
			dosym /usr/share/${package}/lib/${jar_file} ${target}
		else
			ewarn "Target jar does not exist so will not create link: ${D}/${target}"
			NB_DOSYMINSTJARFAILED="1"
		fi
	fi
}
