# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"
JAVA_ANT_ENCODING="iso-8859-1"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Portlet API implementation of JSR 286"
HOMEPAGE="http://jcp.org/aboutJava/communityprocess/final/jsr286/index.html"
SRC_URI="http://hnsp.inf-bb.uni-jena.de/download/RI_JSR286.zip"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"
IUSE=""

CDEPEND="java-virtuals/servlet-api:3.0"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

S="${WORKDIR}/portlet2-api"

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
