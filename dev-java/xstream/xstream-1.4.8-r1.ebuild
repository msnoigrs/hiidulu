# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A text-processing Java classes that serialize objects to XML and back again."
HOMEPAGE="http://x-stream.github.io/"
SRC_URI="http://repo1.maven.org/maven2/com/thoughtworks/xstream/xstream-distribution/${PV}/xstream-distribution-${PV}-src.zip"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEPS="
	dev-java/cglib-nodep:2.2
	dev-java/dom4j:1
	dev-java/jdom:0
	dev-java/jdom:2
	dev-java/kxml:2
	dev-java/joda-time:0
	dev-java/xom:0
	dev-java/xpp3:0
	dev-java/xml-commons-external:1.4
	dev-java/jettison:0
	dev-java/stax
	java-virtuals/stax-api"

DEPEND=">=virtual/jdk-1.6
	${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPS}"

S="${WORKDIR}/${P}/${PN}"

RESTRICT="test"

java_prepare() {
	rm -v src/java/com/thoughtworks/xstream/io/xml/WstxDriver.java
	rm -v src/java/com/thoughtworks/xstream/io/xml/BEAStaxDriver.java

	mkdir lib
	java-pkg_jar-from --into lib xpp3
	java-pkg_jar-from --into lib jdom
	java-pkg_jar-from --into lib jdom-2 jdom.jar jdom2.jar
	java-pkg_jar-from --into lib kxml-2
	java-pkg_jar-from --into lib xom
	java-pkg_jar-from --into lib dom4j-1
	java-pkg_jar-from --into lib joda-time
	java-pkg_jar-from --into lib cglib-nodep-2.2
	java-pkg_jar-from --into lib xml-commons-external-1.4
	java-pkg_jar-from --into lib jettison
	java-pkg_jar-from --into lib stax
	java-pkg_jar-from --into lib --virtual stax-api

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install(){
	java-pkg_newjar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/javadoc
	use source && java-pkg_dosrc src/java/com
}
