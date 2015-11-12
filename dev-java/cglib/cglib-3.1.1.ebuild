# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc"

#WANT_ANT_TASKS="dev-java/jarjar:1"

inherit java-pkg-2 java-ant-2

DESCRIPTION="cglib is a powerful, high performance and quality Code Generation Library."
MY_TARBALL="cglib-3.1.1-e10bc3d.tar.gz"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9534%2F${MY_TARBALL} -> ${MY_TARBALL}"
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

S="${WORKDIR}/${P}-e10bc3d/cglib"

src_unpack() {
	default
	epatch "${FILESDIR}/cglib-ant-build.patch"
	cp "${WORKDIR}/b/cglib/build.xml" "${S}"
}

java_prepare() {
	epatch "${FILESDIR}/no-jarjar-3.patch"

	mkdir -p ${S}/lib
	java-pkg_jar-from --into lib asm-5
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dohtml -r docs/*
}
