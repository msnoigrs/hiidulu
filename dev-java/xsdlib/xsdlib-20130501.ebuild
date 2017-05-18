# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PV="2013.5.1"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="The Sun Multi-Schema XML Validator is a Java tool to validate XML documents against several kinds of XML schemata."
HOMEPAGE=""
SRC_URI="http://repo1.maven.org/maven2/net/java/dev/msv/xsdlib/${MY_PV}/${MY_P}-sources.jar"

LICENSE="as-is Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

RDEPEND=">=virtual/jre-1.6
	>=dev-java/xerces-2.7
	dev-java/relaxng-datatype"
DEPEND=">=virtual/jdk-1.6
	${RDEPEND}"
IUSE=""

S=${WORKDIR}

java_prepare() {
	epatch "${FILESDIR}/RegExpFactory-ClassLoader.patch"
	mkdir src
	mv com src
	cp -i "${FILESDIR}/build-20130501.xml" build.xml || die

	mkdir lib && cd lib
	java-pkg_jarfrom relaxng-datatype
	java-pkg_jarfrom xerces-2

	cd ${S}
	echo "com.sun.msv.datatype.xsd.ngimpl.DataTypeLibraryImpl" > org.relaxng.datatype.DatatypeLibraryFactory
	echo "version=${PV}" > src/version.properties
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/* src-apache/*
}
