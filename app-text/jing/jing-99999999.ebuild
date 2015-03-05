# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="http://jing-trang.googlecode.com/svn/trunk"
WANT_ANT_TASKS="ant-trax dev-java/saxon:9.3 dev-java/testng:0 ant-nodeps"
#WANT_ANT_TASKS="ant-trax dev-java/saxon:9.3 ant-nodeps"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI=""
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
COMMON_DEPEND="
	dev-java/xerces:2
	dev-java/iso-relax
	dev-java/xalan
	dev-java/saxon:9.3
	dev-java/xml-commons-resolver"
#	dev-java/relaxng-datatype
#	dev-java/saxon:9
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	dev-java/javacc
	${COMMON_DEPEND}"

JAVA_PKG_BSFIX="off"

#src_prepare() {
#	cp ${FILESDIR}/build-r1.xml build.xml || die
#
#	mkdir src/
#	cd src/
#	unpack ./../src.zip
#	mkdir -p "${S}/src/META-INF"
#	cp ${FILESDIR}/manifest.mf ${S}/src/META-INF
#	# Has java.util.regex, xerces2 and xerces1 implementation
#	# We only need the first one
##	rm -vr com/thaiopensource/datatype/xsd/regex/xerces2 || die
#	epatch "${FILESDIR}/build-patch.diff"
#
#	#remove bundled relaxng-datatype
#	rm -r org || die
#	cd ../bin/
#	rm -v *.jar || die
java_prepare() {
	#epatch "${FILESDIR}"/schematron-warnings.patch
	epatch "${FILESDIR}/jing-trang-java8.patch"

	find -type f -exec sed -i -e 's/com.icl.saxon/net.sf.saxon/g' {} \;

	rm -fv lib/*.jar
	cd lib
	java-pkg_jar-from iso-relax
	java-pkg_jar-from xerces-2
	java-pkg_jar-from xalan xalan.jar
	java-pkg_jar-from saxon-9.3 saxon9.jar
#	java-pkg_jar-from saxon-9 saxon9.jar saxon.jar
	rm ${S}/mod/schematron/src/main/com/thaiopensource/validate/schematron/OldSaxonSchemaReaderFactory.java
#	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from xml-commons-resolver xml-commons-resolver.jar resolver.jar
	java-pkg_jar-from --build-only ant-core
	java-pkg_jar-from --build-only javacc

}

src_compile() {
	eant modbuild
	java-ant_bsfix_one modbuild.xml
	java-pkg-2_src_compile
}

#src_test() {
#	local cp
#	for jar in bin/*.jar; do
#		cp="${cp}:${jar}"
#	done
	# would need some test files could probably take this from the gcj version
	#java -cp ${cp} com.thaiopensource.datatype.xsd.regex.test.TestDriver || die
	#java -cp ${cp} com.thaiopensource.datatype.relaxng.util.TestDriver || die
	#java -cp ${cp} com.thaiopensource.datatype.xsd.regex.test.CategoryTest \
	#	|| die
#}

src_install() {
	java-pkg_dojar build/jing.jar
	java-pkg_dojar build/trang.jar
	java-pkg_dojar build/dtdinst.jar
	java-pkg_register-ant-task
#	java-pkg_dolauncher ${PN}-${SLOT} --main com.thaiopensource.relaxng.util.Driver
	java-pkg_dolauncher ${PN} --main com.thaiopensource.relaxng.util.Driver
	use doc && java-pkg_dohtml -r doc/* readme.html
	use source && java-pkg_dosrc src/com
}
