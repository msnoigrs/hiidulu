# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

JAVA_ANT_ENCODING="iso-8859-1"

inherit java-pkg-2 java-ant-2

MY_DATE="20031218"

DESCRIPTION="RELAX NG Compiler Compiler"
HOMEPAGE="http://relaxngcc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_DATE}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/iso-relax
	dev-java/relaxng-datatype
	dev-java/msv
	dev-java/xsdlib"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${PN}-${MY_DATE}"

java_prepare() {
	mv relaxngcc.jar relaxngcc.orig.jar || die
	rm -v relaxngDatatype.jar || die
	rm -v xsdlib.jar || die
	rm -v xerces.jar || die
	rm -v msv.jar || die
	sed -i -e 's/enum/e/g' src/relaxngcc/javabody/JavaBodyParser.java

	mkdir -p ${S}/lib || die
	java-pkg_jar-from --into lib relaxng-datatype
	java-pkg_jar-from --into lib msv
	java-pkg_jar-from --into lib xsdlib
	java-pkg_jar-from --into lib iso-relax
	java-pkg_jar-from --into lib --build-only ant-core ant.jar

	cp "${FILESDIR}/build.xml-1.12-r1" build.xml || die "cp failed"
	rm -rf "src/relaxngcc/maven"
}

EANT_DOC_TARGET=""

src_install() {
	java-pkg_dojar relaxngcc.jar
	java-pkg_register-ant-task
	use source && java-pkg_dosrc src/*
	dodoc readme.txt || die
	use doc && dohtml -r doc/en/*
}
