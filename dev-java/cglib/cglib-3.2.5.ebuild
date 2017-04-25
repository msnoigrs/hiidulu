# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc"

#WANT_ANT_TASKS="dev-java/jarjar:1"

inherit java-pkg-2 java-ant-2

MY_PV="RELEASE_3_2_5"

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="https://github.com/cglib/cglib/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~x86"

COMMON_DEP="dev-java/asm:5"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}/${PN}"

src_unpack() {
	default
	epatch "${FILESDIR}/cglib-ant-build-3.2.0.patch"
	cp "${WORKDIR}/b/cglib/build.xml" "${S}"
}

java_prepare() {
	epatch "${FILESDIR}/no-jarjar-3.patch"

	mkdir -p ${S}/lib
	java-pkg_jar-from --into lib asm-5
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${PN}-3.2.0.jar ${PN}.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dohtml -r docs/*
}
