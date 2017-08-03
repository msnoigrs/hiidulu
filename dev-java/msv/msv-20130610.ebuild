# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Multi-Schema XML Validator, a Java tool for validating XML documents"
HOMEPAGE="https://msv.java.net/"
#SRC_URI="http://java.net/downloads/msv/releases/${MY_P}.zip"
MY_TARBALL="${P}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13640%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.6
	dev-java/iso-relax
	dev-java/relaxng-datatype
	dev-java/xml-commons-resolver
	dev-java/xsdlib"
#	>=dev-java/xerces-2.7
DEPEND=">=virtual/jdk-1.6
	${RDEPEND}"

java_prepare() {
	cp "${FILESDIR}/build.xml" build.xml || die

	sed -i -e 's/com.sun.org.apache.xml.internal/org.apache.xml/g' src/com/sun/msv/driver/textui/Driver.java

	mkdir lib && cd lib
	local pkg
#	for pkg in iso-relax relaxng-datatype xerces-2 xml-commons-resolver xsdlib; do
	for pkg in iso-relax relaxng-datatype xml-commons-resolver xsdlib; do
		java-pkg_jar-from ${pkg}
	done
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dojavadoc dist/doc/api
	use source && java-pkg_dosrc src/*
}
