# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/msv~svn/trunk/msv"

inherit subversion java-pkg-2 java-ant-2

#MY_P="${PN}.${PV}"
DESCRIPTION="Multi-Schema XML Validator, a Java tool for validating XML documents"
HOMEPAGE="https://msv.java.net/"
#SRC_URI="http://java.net/downloads/msv/releases/${MY_P}.zip"
SRC_URI=""

LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	dev-java/iso-relax
	dev-java/relaxng-datatype
	dev-java/xml-commons-resolver
	dev-java/xsdlib"
#	>=dev-java/xerces-2.7
DEPEND=">=virtual/jdk-1.5
	${RDEPEND}"

java_prepare() {
	cp "${FILESDIR}/build.xml" build.xml || die

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
