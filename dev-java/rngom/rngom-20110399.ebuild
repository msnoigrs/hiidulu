# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

WANT_ANT_TASKS="ant-nodeps"

inherit java-pkg-2 java-ant-2

DESCRIPTION="RNGOM is an open-source Java library for parsing RELAX NG grammars."
HOMEPAGE="https://rngom.java.net/"
#SRC_URI="https://rngom.dev.java.net/files/documents/1647/26424/${P}.zip"
MY_TARBALL="${PN}-201103.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13642%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/relaxng-datatype"

DEPEND=">=virtual/jdk-1.6
	dev-java/javacc
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${PN}-201103"

java_prepare() {
#	epatch ${FILESDIR}/without-retroweaver.patch

	epatch "${FILESDIR}/qname-prefix.patch"

	cp "${FILESDIR}/gentoo-build.xml" build.xml || die

	cd lib
	java-pkg_jar-from relaxng-datatype
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/doc/api
	use source && java-pkg_dosrc src/*
}
