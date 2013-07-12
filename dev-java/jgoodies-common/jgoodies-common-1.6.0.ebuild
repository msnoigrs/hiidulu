# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="common"
MY_PV=${PV//./_}
MY_P="${PN}-${MY_PV}"
DESCRIPTION="JGoodies Common Library"
HOMEPAGE="http://www.jgoodies.com/"
SRC_URI="http://www.jgoodies.com/download/libraries/${MY_PN}/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}/src/main/java"
	cd "${S}/src/main/java"
	jar -xf "${S}/${P}-sources.jar"
}

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml
	# Remove the packaged jars
	rm -v *.jar || die "rm failed"
}

EANT_EXTRA_ARGS="-Dbuild.boot.classpath=\"$(java-config -g BOOTCLASSPATH)\" -Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	dodoc README.html || die

	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/main/java/com
}
