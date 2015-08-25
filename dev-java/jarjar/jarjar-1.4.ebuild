# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Tool for repackaging third-party jars."
SRC_URI="https://jarjar.googlecode.com/files/${PN}-src-${PV}.zip"
HOMEPAGE="https://code.google.com/p/jarjar/"
LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~x86 ~amd64"
IUSE="test"
#COMMON_DEP="dev-java/asm:4"
COMMON_DEP="dev-java/asm:5"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}
	dev-java/ant-core
	test? ( dev-java/ant-junit )"

#S="${WORKDIR}/${PN}-${MY_PV}"

java_prepare() {
	# remove maven dependency
	rm -v src/main/com/tonicsystems/jarjar/JarJarMojo.java || die

	epatch "${FILESDIR}/0.9-bootclasspath.patch"

	# without <keep> directive version
	#epatch "${FILESDIR}/jarjar-gentoo.patch"
	# with <keep> directive version
	epatch "${FILESDIR}/jarjar-gentoo-2.patch"
	# see http://code.google.com/p/jarjar/issues/detail?id=20
	#epatch "${FILESDIR}/KeepProcessor.patch"

	# for ant 1.8*
	# http://patch-tracker.debian.org/patch/series/dl/jarjar/1.0+dfsg-2/0005-cast-null-to-java.io.File.patch
	#epatch "${FILESDIR}/0005-cast-null-to-java.io.File.patch"
	#epatch "${FILESDIR}/1.0-ant-1.8-compat.patch"

	sed -i -e 's/Opcodes.ASM4/Opcodes.ASM5/g' \
		src/main/com/tonicsystems/jarjar/EmptyClassVisitor.java \
		src/main/com/tonicsystems/jarjar/StringReader.java

	cd "${S}/lib"
	rm -v *.jar || die
	#java-pkg_jar-from asm-4 asm.jar asm-4.0.jar
	#java-pkg_jar-from asm-4 asm-commons.jar asm-commons-4.0.jar
	java-pkg_jar-from asm-5 asm.jar asm-4.0.jar
	java-pkg_jar-from asm-5 asm-commons.jar asm-commons-4.0.jar
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
	java-pkg_newjar dist/${PN}-1.4.jar ${PN}.jar
	java-pkg_newjar dist/${PN}-nodep-1.4.jar ${PN}-nodep.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/main/*
}
