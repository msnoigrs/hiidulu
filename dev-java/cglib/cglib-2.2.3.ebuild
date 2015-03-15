# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc"

#WANT_ANT_TASKS="dev-java/jarjar:1"

inherit java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="https://github.com/cglib/cglib/archive/Root_RELEASE_2_2_3.tar.gz -> ${P}.tar.gz"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~x86"

COMMON_DEP="dev-java/asm:3"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
IUSE=""

S="${WORKDIR}/${PN}-Root_RELEASE_${PV//./_}"

java_prepare() {
	#epatch "${FILESDIR}/cglib-2.2.3-build.patch"
	epatch "${FILESDIR}/no-jarjar.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-3
	java-pkg_jar-from --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${PN}-2.2.jar ${PN}.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dohtml -r docs/*
}
