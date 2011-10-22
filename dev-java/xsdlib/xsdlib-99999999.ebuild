# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/msv~svn/trunk/xsdlib"

inherit subversion eutils java-pkg-2 java-ant-2

MY_P="${PN}.${PV}"
DESCRIPTION="The Sun Multi-Schema XML Validator is a Java tool to validate XML documents against several kinds of XML schemata."
HOMEPAGE="https://msv.java.net/"
#SRC_URI="http://java.net/downloads/msv/releases/${MY_P}.zip"
SRC_URI=""

LICENSE="as-is Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.5
	>=dev-java/xerces-2.7
	dev-java/relaxng-datatype"
DEPEND=">=virtual/jdk-1.5
	${RDEPEND}"
IUSE=""

java_prepare() {
	epatch "${FILESDIR}/RegExpFactory-ClassLoader.patch"
	cp "${FILESDIR}/build-9999.xml" build.xml || die

	echo "version=20090415" > src/version.properties

	mkdir lib && cd lib
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom xerces-2
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/* src-apache/*
}
