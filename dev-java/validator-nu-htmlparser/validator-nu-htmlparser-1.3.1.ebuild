# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P="htmlparser-${PV}"

DESCRIPTION="the HTML5 parsing algorithm in Java"
HOMEPAGE="http://about.validator.nu/htmlparser/"
SRC_URI="http://about.validator.nu/htmlparser/${MY_P}.zip"

LICENSE="BSD-2 MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

COMMON_DEP="
	dev-java/jchardet
	dev-java/xom
	dev-java/icu4j:4.6"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/javaparser
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	rm -v *.jar

	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib xom
	java-pkg_jar-from --into lib icu4j-4.6 icu4j.jar
	java-pkg_jar-from --into lib jchardet
	java-pkg_jar-from --into lib --build-only javaparser


	# for netbeans
	sed -i -e 's/public final void startTag/public void startTag/' \
		-e 's/public final void endTag/public void endTag/' \
		src/nu/validator/htmlparser/impl/TreeBuilder.java
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=htmlparser"

src_install() {
	java-pkg_dojar target/htmlparser.jar
	java-pkg_dojar target/htmlparser-with-transitions.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*

#	java-pkg_dolauncher xslt4html5 --main nu.validator.htmlparser.tools.XSLT4HTML5
#	java-pkg_dolauncher xslt4html5xom --main nu.validator.htmlparser.tools.XSLT4HTML5XOM
#	java-pkg_dolauncher html2xml --main nu.validator.htmlparser.tools.HTML2XML
#	java-pkg_dolauncher xml2html --main nu.validator.htmlparser.tools.XML2HTML
#	java-pkg_dolauncher xml2xml --main nu.validator.htmlparser.tools.XML2XML
#	java-pkg_dolauncher html2html --main nu.validator.htmlparser.tools.HTML2HTML
}
