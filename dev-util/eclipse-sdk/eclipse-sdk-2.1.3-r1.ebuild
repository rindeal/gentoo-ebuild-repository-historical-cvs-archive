# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-2.1.3-r1.ebuild,v 1.1 2004/04/01 16:27:31 st_lim Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.1.3-200403101828/eclipse-sourceBuild-srcIncluded-2.1.3.zip"
IUSE="gtk motif gnome kde"

SLOT="0"
LICENSE="CPL-1.0"
KEYWORDS="~x86 ~ppc ~sparc"

RDEPEND=">=virtual/jdk-1.3
	gtk? ( >=x11-libs/gtk+-2.4 ) :
	( kde? ( kde-base/kde x11-libs/openmotif ) :
	  ( motif? ( x11-libs/openmotif ) :
	    ( >=x11-libs/gtk+-2.4 )
	  )
	)
	gnome? ( =gnome-base/gnome-vfs-2* )
	"
# 2004-03-28: karltk
# It would be nice if this worked, but portage doesn't handle it properly
#	|| (
#	    gtk? ( >=x11-libs/gtk+-2.4 )
#	    kde? ( kde-base/kde x11-libs/openmotif )
#	    motif? ( x11-libs/openmotif )
#	    >=x11-libs/gtk+-2.4
#	)

DEPEND="${RDEPEND}
	>=dev-java/ant-1.5.3
	>=sys-apps/findutils-4.1.7
	>=app-shells/tcsh-6.11"

S=${WORKDIR}/eclipse

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/00-refactor_rename.patch
	#epatch ${FILESDIR}/${P}-build.patch

	# performing the cleaning here so we can actually run a compile stage
	# without loosing all previous compilation results
	addwrite "/proc/self/maps"
	ant -Dws=gtk -Dos=linux clean
	ant -Dws=motif -Dos=linux clean
}

src_compile() {

	# This ebuild is doing some slightly funky things since the
	# source tarball also contains all the binaries for eclipse.  On
	# top of this, there are a ton of files that need to be merged
	# so instead of specifying all these files, we're instead
	# removing all the extra fluff from the source tree and then
	# merging it all over when we're done.

	# This ebuild will compile eclipse for gtk2, motif, and kde
	# toolkits depending on the use flags set.  If all are set, the
	# default version linked to is the GTK2 version.  When building
	# for KDE though, the motif version must be built with support
	# for KDE.  Apparently the motif build also supports KDE when
	# this is done - I could be wrong though.

	if [ ! -z "`java-config --java-version | grep IBM`" ] ; then
		ANT_EXTRA_OPTS="-Dbootclasspath=`java-config --jdk-home`/jre/lib/core.jar"
	fi

	gtk_launcher_src_dir="${WORKDIR}/plugins/platform-launcher/library/gtk"
	motif_launch_src_dir="${WORKDIR}/plugins/platform-launcher/library/motif"
	gtk_swt_src_dir=${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT\ PI/gtk/library
	motif_swt_src_dir=${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT\ PI/motif/library

	core_src_dir="${WORKDIR}/plugins/org.eclipse.core.resources.linux/src"

	case $ARCH in
		sparc)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/solaris/sparc"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/solaris/sparc"
			core_dest_dir="${WORKDIR}/plugins/org.eclipse.core.resources.linux/os/solaris/sparc/"
			;;
		x86)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/linux/x86"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/linux/x86"
			core_dest_dir="${WORKDIR}/plugins/org.eclipse.core.resources.linux/os/linux/x86/"
			;;
		ppc)
			gtk_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.gtk/os/linux/ppc"
			motif_swt_dest_dir="${WORKDIR}/plugins/org.eclipse.swt.motif/os/linux/ppc"
			core_dest_dir="${WORKDIR}/plugins/org.eclipse.core.resources.linux/os/linux/ppc/"
			;;
	esac

	use gtk && gtk=y
	use motif && motif=y
	use gnome && gnome=y gtk=y
	use kde && kde=y motif=y

	# force gtk to be the default if motif isn't selected
	if ! [ ${motif} = "y" ] ; then
		gtk=y
	fi

	cd ${WORKDIR}

	# First build all java code

	# this export is pulled from the build shellscript supplied by
	# eclipse. It fixes an outOfMemory exception during the ant build
	# process.
	export ANT_OPTS=-Xmx256m

	# remove all .so files shipped with the tarball
	find ${WORKDIR} -name '*.so' -exec rm -f {} \;

	# remove the eclipse binary copied from the ant build above.
	rm -f ${WORKDIR}/eclipse

	override_motif_target=
	if [ "${gtk}" = "y" ] ; then
		einfo "Building GTK+ frontend"
		ant -buildfile build.xml -Dos=linux -Dws=gtk ${ANT_EXTRA_OPTS} || die "something went wrong"
		#only do a compile/install for motif...  Don't do a buildDoc.  This will save time...
		override_motif_target="compile install"
	fi
	if [ "${motif}" = "y" ] ; then
		einfo "Building Motif frontend"
		ant -buildfile  build.xml -Dos=linux -Dws=motif ${ANT_EXTRA_OPTS} ${override_motif_target} || die "something went wrong"
	fi

	einfo "building resources.core plugin"
	cd ${core_src_dir}
	make JDK_INCLUDE="`java-config -O`/include -I`java-config -O`/include/linux"
	mkdir -p "${core_dest_dir}"
	mv *.so "${core_dest_dir}"

	# I'm replacing these pkg-config lines since --libs for them
	# returns -pthread instead of -lpthread and remove the -Wl, since
	# ld doesn't know what to do with it.

	GNOME_LIB=`pkg-config --libs gnome-vfs-2.0 | sed -e "s:-pthread:-lpthread:" -e "s:-Wl,--export:--export:"`
	GTHREAD_LIB=`pkg-config --libs gthread-2.0 | sed -e "s:-pthread:-lpthread:"`

	# Build for the gtk toolkit
	if [ "${gtk}" = "y" ] ; then
		einfo "building gtk swt"
		# Build the eclipse gtk binary
		cd ${WORKDIR}/plugins/platform-launcher/library/gtk
		tcsh build.csh -output eclipse-gtk -arch $ARCH || die
		mv eclipse-gtk ${WORKDIR}/eclipse-gtk

		cd "${gtk_swt_src_dir}"
		cp ${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .

		sed -e "s:/bluebird/teamswt/swt-builddir/ive:$JAVA_HOME:" \
		    -e "s:JAVA_JNI=\$(IVE_HOME)/bin/include:JAVA_JNI=\$(IVE_HOME)/include:" \
	    	-e "s:\`pkg-config --libs gthread-2.0\`:${GTHREAD_LIB}:" \
		    -e "s:\`pkg-config --libs gnome-vfs-2.0\`:${GNOME_LIB}:" \
			-e "s:-I\$(JAVA_JNI):-I\$(JAVA_JNI) -I\$(JAVA_JNI)/linux:" \
		-i make_gtk.mak

		# It appears that gtk+-2.4 which most everyone should be using by
		# now deprecates the use of combobox.  But eclipse is apparently
		# still using this deprecation
		sed -e "s:#define GTK_DISABLE_DEPRECATED::g" -i swt.c

		make -f make_gtk.mak make_swt
		if [ "${gnome}" = "y" ] ; then
			make -f make_gtk.mak make_gnome
		fi

		# move the *.so files to the right path so eclipse can find them
		mkdir -p "${gtk_swt_dest_dir}"
		mv *.so "${gtk_swt_dest_dir}"
		make -f make_linux.mak clean   #do a clean since everything is going to end up getting merged
	fi

	# Build for the motif toolkit
	if [ "${motif}" = "y" ] ; then
		# Build the eclipse motif binary
		cd ${WORKDIR}/plugins/platform-launcher/library/motif
		tcsh build.csh -output eclipse-motif -arch $ARCH || die
		mv eclipse-motif ${WORKDIR}/eclipse-motif

		cd "${motif_swt_src_dir}"
		cp ${WORKDIR}/plugins/org.eclipse.swt/Eclipse\ SWT/common/library/* .

		sed -e "s:/bluebird/teamswt/swt-builddir/ive:$JAVA_HOME:" \
		    -e "s:JAVA_JNI=\$(IVE_HOME)/bin/include:JAVA_JNI=\$(IVE_HOME)/include:" \
			-e "s:/bluebird/teamswt/swt-builddir/motif21:/usr/X11R6:" \
	    	-e "s:\`pkg-config --libs gthread-2.0\`:${GTHREAD_LIB}:" \
		    -e "s:\`pkg-config --libs gnome-vfs-2.0\`:${GNOME_LIB}:" \
			-e "s:/usr/lib/qt3:/usr/qt/3:" \
			-e "s:-lkdecore:-L\`kde-config --prefix\`/lib -lkdecore:" \
			-e "s:-I/usr/include/kde:-I\`kde-config --prefix\`/include:" \
			-e "s:-I\$(JAVA_JNI):-I\$(JAVA_JNI) -I\$(JAVA_JNI)/linux:" \
		-i make_linux.mak

		make -f make_linux.mak make_swt
		if [ "${gnome}" = "y" ] ; then
			make -f make_linux.mak make_gnome
		fi
		if [ "${kde}" = "y" ] ; then
			make -f make_linux.mak make_kde
		fi

		# move the *.so files to the right path so eclipse can find them
		mkdir -p "${motif_swt_dest_dir}"
		mv *.so "${motif_swt_dest_dir}"
		make -f make_linux.mak clean   #do a clean since everything is going to end up getting merged
	fi


	# remove all the java files so we can install this. 
	# there is no install target in build.xml for some reason and
	# we don't want all of these files merged.
	# also remove all the .project, .classpath and build.* files spread out all over the place
	find ${WORKDIR} -name '*.java' -exec rm -f {} \;
	find ${WORKDIR} -name '.classpath' -exec rm -f {} \;
	find ${WORKDIR} -name '.project'  -exec rm -f {} \;
	find ${WORKDIR} -name 'build.*' -exec rm -f {} \;

}

src_install() {
	cd ${WORKDIR}

	exeinto /usr/bin
	doexe ${FILESDIR}/eclipse

	dodir /usr/lib/eclipse
	exeinto /usr/lib/eclipse

	if [ -f eclipse-gtk ] ; then
		doexe eclipse-gtk
		dosym /usr/lib/eclipse/eclipse-gtk /usr/lib/eclipse/eclipse
	fi
	if [ -f eclipse-motif ] ; then
		doexe eclipse-motif
		dosym /usr/bin/eclipse /usr/bin/eclipse-motif
		if ! [ -f eclipse-gtk ] ; then
			dosym /usr/lib/eclipse/eclipse-motif /usr/lib/eclipse/eclipse
		fi
	fi

	insinto /usr/lib/eclipse
	doins plugins/org.eclipse.platform/.eclipseproduct

	cp -dpR features icon.xpm plugins splash.bmp startup.jar \
		${D}/usr/lib/eclipse/

	insinto /usr/share/gnome/apps/Development
	doins ${FILESDIR}/eclipse.desktop
}
