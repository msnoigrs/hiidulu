# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc"

WANT_ANT_TASKS="dev-java/jarjar:1"

inherit java-pkg-2 java-ant-2

MY_PV="RELEASE_3_2_0"

MY_PN="cglib"
DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="https://github.com/cglib/cglib/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	dev-java/asm:5"
IUSE=""

S="${WORKDIR}/${MY_PN}-${MY_PV}/${MY_PN}"

src_unpack() {
	default
	epatch "${FILESDIR}/cglib-ant-build-3.2.0.patch"
	cp "${WORKDIR}/b/cglib/build.xml" "${S}"
}

java_prepare() {
	mkdir -p "${S}/lib"
	cd "${S}/lib"
	java-pkg_jar-from --build-only asm-5 asm.jar
	java-pkg_jar-from --build-only asm-5 asm-analysis.jar
	java-pkg_jar-from --build-only asm-5 asm-tree.jar
	java-pkg_jar-from --build-only asm-5 asm-xml.jar
	java-pkg_jar-from --build-only asm-5 asm-commons.jar
	java-pkg_jar-from --build-only asm-5 asm-util.jar
	java-pkg_jar-from --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${MY_PN}-nodep-${PV}.jar ${MY_PN}-nodep.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dohtml -r docs/*
}
