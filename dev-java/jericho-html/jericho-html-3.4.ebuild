# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Analysis and manipulation of parts of an HTML document"
HOMEPAGE="http://jericho.htmlparser.net/docs/index.html"
SRC_URI="mirror://sourceforge/jerichohtml/jericho-html/${P}.zip"

LICENSE="|| ( EPL-1.0 LGPL-2.1 Apache-2.0 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.7
	dev-java/slf4j-api"
RDEPEND=">=virtual/jre-1.7"

java_prepare() {
	rm -v dist/${P}.jar
	rm -v compile-time-dependencies/*.jar
	rm -r classes

	rm src/java/net/htmlparser/jericho/LoggerProviderLog4J.java
	rm src/java/net/htmlparser/jericho/LoggerProviderJCL.java
	epatch "${FILESDIR}"/remove-jcl-log4j.patch

	mkdir lib || die
	java-pkg_jar-from --into lib --build-only slf4j-api
	#java-pkg_jar-from --into lib --build-only log4j
	#java-pkg_jar-from --into lib --build-only commons-logging
	cp "${FILESDIR}"/gentoo-build.xml build.xml
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/java/*
}
