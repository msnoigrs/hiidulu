# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://jarjar.googlecode.com/svn/trunk/jarjar"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Tool for repackaging third-party jars."
#SRC_URI="http://jarjar.googlecode.com/files/${P}.jar"
SRC_URI=""
HOMEPAGE="http://http://code.google.com/p/jarjar/"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE="test"
COMMON_DEP="dev-java/asm:3"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	dev-java/ant-core
	test? ( dev-java/ant-junit )"

#S="${WORKDIR}/${PN}-${MY_PV}"

#JAVA_PKG_BSFIX="off"

java_prepare() {
	# remove maven dependency
	rm -v src/main/com/tonicsystems/jarjar/JarJarMojo.java || die

	epatch "${FILESDIR}/0.9-bootclasspath.patch"

	# without <keep> directive version
	#epatch "${FILESDIR}/jarjar-gentoo.patch"
	# with <keep> directive version
	epatch "${FILESDIR}/jarjar-gentoo-2.patch"
	# see http://code.google.com/p/jarjar/issues/detail?id=20
	epatch "${FILESDIR}/KeepProcessor.patch"

	# for ant 1.8*
	# http://patch-tracker.debian.org/patch/series/dl/jarjar/1.0+dfsg-2/0005-cast-null-to-java.io.File.patch
	#epatch "${FILESDIR}/0005-cast-null-to-java.io.File.patch"
	#epatch "${FILESDIR}/1.0-ant-1.8-compat.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-3 asm.jar asm-3.3.1.jar
	java-pkg_jar-from asm-3 asm-commons.jar asm-commons-3.3.1.jar
	java-pkg_jar-from --build-only ant-core ant.jar
}

EANT_BUILD_TARGET="jar-nojarjar jar"

src_test() {
	# regenerates this
	cp dist/${P}.jar -i "${T}" || die
	cd lib || die
	java-pkg_jar-from junit
	cd ..
	ANT_TASKS="ant-junit" eant test
	cp "${T}/${P}.jar" dist || die
}

src_install() {
	java-pkg_newjar dist/${PN}-1.2.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-nodep-1.2.jar ${PN}-nodep.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/main/*
}
