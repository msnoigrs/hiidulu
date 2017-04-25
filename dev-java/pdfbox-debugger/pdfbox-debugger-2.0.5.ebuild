# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MY_PN="pdfbox"
MY_P="${MY_PN}-${PV}"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java library and utilities for working with PDF documents"
HOMEPAGE="http://www.pdfbox.org"
SRC_URI="mirror://apache/${MY_PN}/${PV}/${MY_P}-src.zip"
LICENSE="Apache-2.0"
SLOT="2.0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CDEPEND="dev-java/pdfbox:${SLOT}"
RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}/debugger"

java_prepare() {
	cd debugger
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir "lib" || die
	cd "lib"

	java-pkg_jar-from pdfbox-2.0
}
EANT_EXTRA_ARGS="-Dproject.name=${PN}"
src_compile() {
	cd debugger
	java-pkg-2_src_compile
}

src_install() {
	cd debugger
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
