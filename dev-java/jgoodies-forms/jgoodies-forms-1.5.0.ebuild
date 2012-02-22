# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_PN="forms"
MY_PV=${PV//./_}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="JGoodies Forms Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/jgoodies-common"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

#S="${WORKDIR}/${MY_PN}-${PV}"

java_prepare() {
	sed -i -e 's:\${lib.common.jar}:lib/jgoodies-common.jar:g' build.xml

	# Remove the packaged jars
	rm -v *.jar lib/*.jar || die "rm failed"

	java-pkg_jar-from --into lib jgoodies-common
}

src_compile() {
	EANT_EXTRA_ARGS="-Dbuild.boot.classpath=\"$(java-config -g BOOTCLASSPATH)\"" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar build/${PN}.jar

	dodoc RELEASE-NOTES.txt README.html || die

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/{core,extras}/com
	use examples && java-pkg_doexamples src/tutorial
}
