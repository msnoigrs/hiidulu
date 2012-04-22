# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Jing: A RELAX NG validator in Java"
HOMEPAGE="http://thaiopensource.com/relaxng/jing.html"
SRC_URI="http://jing-trang.googlecode.com/files/${P}.zip"
LICENSE="BSD Apache-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="doc source"
COMMON_DEPEND="
	dev-java/saxon:9
	dev-java/xerces:2
	dev-java/iso-relax
	dev-java/xalan
	dev-java/relaxng-datatype"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	app-arch/unzip
	source? ( app-arch/zip )
	${COMMON_DEPEND}"

java_prepare() {
	cp ${FILESDIR}/build-r1.xml build.xml || die

	mkdir src/
	cd src/
	unpack ./../src.zip
	mkdir -p "${S}/src/META-INF"
	cp ${FILESDIR}/manifest.mf ${S}/src/META-INF
	# Has java.util.regex, xerces2 and xerces1 implementation
	# We only need the first one
#	rm -vr com/thaiopensource/datatype/xsd/regex/xerces2 || die
	epatch "${FILESDIR}/build-patch.diff"

	#remove bundled relaxng-datatype
	rm -r org || die

	cd ../bin/
	rm -v *.jar || die
	java-pkg_jar-from iso-relax
	java-pkg_jar-from xerces-2
	java-pkg_jar-from xalan
	java-pkg_jar-from saxon-9 saxon9.jar saxon.jar
	java-pkg_jar-from relaxng-datatype
	java-pkg_jar-from --build-only ant-core
}

src_compile() {
	eant jar #premade javadocs
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
	java-pkg_dojar bin/jing.jar
	java-pkg_register-ant-task
	java-pkg_dolauncher ${PN} --main com.thaiopensource.relaxng.util.Driver
	use doc && java-pkg_dohtml -r doc/* readme.html
	use source && java-pkg_dosrc src/com
}
