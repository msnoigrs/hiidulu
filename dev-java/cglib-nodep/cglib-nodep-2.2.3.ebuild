# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
WANT_ANT_TASKS="dev-java/jarjar:1"
JAVA_PKG_IUSE="doc"

inherit java-pkg-2 java-ant-2

MY_PN="cglib"
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="https://github.com/cglib/cglib/archive/Root_RELEASE_2_2_3.tar.gz -> ${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	dev-java/asm:3"
IUSE=""

S="${WORKDIR}/${MY_PN}-Root_RELEASE_${PV//./_}"

JAVA_PKG_BSFIX="off"

java_prepare() {
	epatch "${FILESDIR}/cglib-2.2.3-build.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from --build-only asm-3 asm.jar
	java-pkg_jar-from --build-only asm-3 asm-analysis.jar
	java-pkg_jar-from --build-only asm-3 asm-tree.jar
	java-pkg_jar-from --build-only asm-3 asm-xml.jar
	java-pkg_jar-from --build-only asm-3 asm-commons.jar
	java-pkg_jar-from --build-only asm-3 asm-util.jar
	java-pkg_jar-from --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${MY_PN}-nodep-2.2.jar ${MY_PN}-nodep.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dohtml -r docs/*
}
