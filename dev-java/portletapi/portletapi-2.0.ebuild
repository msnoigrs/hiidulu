# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"
JAVA_ANT_ENCODING="iso-8859-1"

inherit java-pkg-2 java-ant-2

RI_URI="http://download.oracle.com/otndocs/jcp/portlet-2.0-fr-oth-JSpec/"

DESCRIPTION="Portlet API implementation of JSR 286"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/final/jsr286/index.html"
#SRC_URI="http://hnsp.inf-bb.uni-jena.de/download/RI_JSR286.zip"
MY_TARBALL="portlet-2.0-fr.zip"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=ymu&f=%2Fusers%2F13%2F13638%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

RESTRICT="strip"

CDEPEND="java-virtuals/servlet-api:3.0"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}/portlet2-api"

src_unpack() {
	unpack ${A}
	mkdir -p "${S}"
	cd "${S}"
	unpack "${WORKDIR}/final/src.zip"
}

java_prepare() {
	cp "${FILESDIR}/${P}-build.xml" "${S}/build.xml" || die
	mkdir -p "${S}/target/lib" || die
	cd "${S}/target/lib"
	java-pkg_jar-from servlet-api-3.0 servlet-api.jar
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/javax
}
