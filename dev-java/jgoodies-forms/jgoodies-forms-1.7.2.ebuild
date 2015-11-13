# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_PN="forms"
MY_PV=${PV//./_}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="1.7"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/jgoodies-common:1.7"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}/src/main/java"
	cd "${S}/src/main/java"
	jar -xf "${S}/${P}-sources.jar"
}

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib jgoodies-common-1.7
}

src_compile() {
	EANT_EXTRA_ARGS="-Dbuild.boot.classpath=\"$(java-config -g BOOTCLASSPATH)\" -Dproject.name=${PN}" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	dodoc  README.html || die

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/main/java/com
}
