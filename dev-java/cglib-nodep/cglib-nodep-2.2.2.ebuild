# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WANT_ANT_TASKS="dev-java/jarjar:1"
JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2

MY_PN="cglib"
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	dev-java/asm:3"
IUSE=""

S=${WORKDIR}

JAVA_PKG_BSFIX="off"

src_unpack() {
	jar xf "${DISTDIR}/${A}" || die "failed to unpack"
}

java_prepare() {
	epatch "${FILESDIR}/cglib-2.2.2-build.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from --build-only asm-3 asm.jar asm-3.3.1.jar
	java-pkg_jar-from --build-only asm-3 asm-analysis.jar
	java-pkg_jar-from --build-only asm-3 asm-tree.jar
	java-pkg_jar-from --build-only asm-3 asm-xml.jar
	java-pkg_jar-from --build-only asm-3 asm-commons.jar
	java-pkg_jar-from --build-only asm-3 asm-util.jar
	java-pkg_jar-from --build-only ant-core ant.jar

	java-pkg_jar-from --build-only jarjar-1 jarjar.jar
}

src_install() {
	java-pkg_newjar dist/${MY_PN}-nodep-${PV}.jar ${MY_PN}-nodep.jar
	java-pkg_register-ant-task
	dodoc NOTICE README || die
	use doc && java-pkg_dohtml -r docs/*
}
