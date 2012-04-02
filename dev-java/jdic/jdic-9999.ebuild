# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source examples"

ESVN_REPO_URI="https://svn.java.net/svn/jdic~svn/trunk/src"

inherit eutils subversion java-pkg-2 java-ant-2

DESCRIPTION="The JDesktop Integration Components (JDIC) API"
HOMEPAGE="http://java.net/projects/jdic/"
#SRC_URI="https://jdic.dev.java.net/files/documents/880/98882/${P}-src.zip"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="net-libs/xulrunner
	gnome-base/gconf
	dev-libs/nspr"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	dev-util/pkgconfig"
RDEPEND=">=virtual/jre-1.5
		${COMMON_DEP}"
#	gnome-base/gnome-vfs
#	gnome-base/orbit
#	gnome-base/libbonobo

#JAVA_PKG_BSFIX="false"

java_prepare() {

##	epatch "${FILESDIR}/0.9.5-build-fix.patch"
	epatch "${FILESDIR}/9999-build-fix-1.patch"
	epatch "${FILESDIR}/9999-without-packager.patch"
	epatch "${FILESDIR}/9999-build-fix-2.patch"
	epatch "${FILESDIR}/9999-build-gentoo.patch"
##	epatch "${FILESDIR}/0.9.5-jnlp.patch"
	epatch "${FILESDIR}/0.9.5-demos_README.patch"
#	epatch "${FILESDIR}/0.9.5-load_native_library.patch"
	epatch "${FILESDIR}/9999-mozilla_to_firefox.patch"
	epatch "${FILESDIR}/9999-jdic-gnome3.patch"


	sed -i -e 's/Desktop/org.jdesktop.jdic.desktop.Desktop/g' jdic/demo/FileChooser/FileChooser.java
	sed -i -e 's/Desktop\./org.jdesktop.jdic.desktop.Desktop./g' jdic/demo/FileExplorer/FileExplorer.java
	sed -i -e 's/ SystemTray/ org.jdesktop.jdic.tray.SystemTray/g' \
		-e 's/ TrayIcon/ org.jdesktop.jdic.tray.TrayIcon/g' \
		jdic/demo/Tray/Tray.java


#	sed -i -e 's/mozilla/firefox/g' ${S}/jdic/src/unix/native/jni/WebBrowserUtil.cpp

	local jhome="$(java-config -O)"
	mkdir -p ${S}/jdic/dist/linux
	mkdir -p ${S}/packager/dist/linux
	ln -s ${jhome}/jre/lib/javaws.jar ${S}/jdic/dist/linux/javaws.jar
	ln -s ${jhome}/jre/lib/javaws.jar ${S}/packager/dist/linux/javaws.jar
	ln -s ${jhome}/jre/lib/deploy.jar ${S}/packager/dist/linux/deploy.jar
}

src_compile() {
	#MOZILLA_PKG_CONFIG="gecko-sdk-gtkmozembed" eant buildall
#	local mozilla_pkg_config="gecko-sdk-tgkmozembed"
#	local mozilla_dist=$(pkg-config --variable=libdir ${mozilla_pkg_config})
#	local gecko_sdk=$(pkg-config --variable=includedir ${mozilla_pkg_config})
	local mozilla_dist="/usr/$(get_libdir)/xulrunner-2.0"
	local gecko_sdk="/usr/$(get_libdir)/xulrunner-devel-2.0"

#	local jhome="$(java-config -O)"
#	CPPFLAGS=
#	JAVA_HOME="${jhome}"
#	CLASSPATH="${jhome}/jre/lib/javaws.jar:${jhome}/jre/lib/deploy.jar" \
	MOZILLA_DIST=${mozilla_dist} \
	GECKO_SDK=${gecko_sdk} \
	CXXFLAGS="${CXXFLAGS} -DDEBUG" \
		eant buildall
}

src_install() {
	cd ${S}/dist/linux
	java-pkg_dojar jdic.jar
#	java-pkg_dojar packager.jar
	java-pkg_doso libtray.so
	java-pkg_doso libjdic.so
	dolib libmozembed-linux-gtk2.so
#	dobin jnlp2rpm
#	dodoc defmailer.properties
	exeinto /usr/share/jdic/lib
	doexe mozembed-linux-gtk2
	use doc && java-pkg_dohtml -r ${S}/../docs/*
	use source && java-pkg_dosrc ${S}/src/share/classes/* ${S}/src/unix/classes/*
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r ${S}/demo/Tray/* ${D}/usr/share/doc/${PF}/examples/
	fi
}
