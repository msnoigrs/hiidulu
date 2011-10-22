# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.jar"
HOMEPAGE="http://cglib.sourceforge.net"
LICENSE="Apache-2.0"
SLOT="2.2"
KEYWORDS="~amd64 ~ppc ~x86"

COMMON_DEP="dev-java/asm:3"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
IUSE=""

S=${WORKDIR}

src_unpack() {
	jar xf "${DISTDIR}/${A}" || die "failed to unpack"
}

java_prepare() {
	epatch "${FILESDIR}/cglib-2.2.1-snapshot.patch"
	epatch "${FILESDIR}/no-jarjar.patch"

	cd "${S}/lib"
	rm -v *.jar || die
	java-pkg_jar-from asm-3
	java-pkg_jar-from --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar
	java-pkg_register-ant-task
	dodoc NOTICE README || die
	use doc && java-pkg_dohtml -r docs/*
}
