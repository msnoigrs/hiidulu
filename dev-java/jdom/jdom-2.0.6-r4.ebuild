# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="https://github.com/hunterhacker/jdom/archive/JDOM-${PV}.zip"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="2"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	dev-java/junit:4
	dev-java/jaxen:1.1"
IUSE=""

S="${WORKDIR}/${PN}-JDOM-${PV}"

java_prepare() {
	sed -i 's/compile, javadoc/compile/' build.xml
	mkdir -p build/apidocs

	rm -v lib/*.jar || die

	rm -v contrib/src/java/org/jdom2/contrib/android/TranslateTests.java

	cd ${S}/lib

	java-pkg_jar-from --build-only jaxen-1.1 jaxen.jar jaxen-1.1.6.jar
	java-pkg_jar-from --build-only junit-4 junit.jar junit-4.8.2.jar
}

src_compile() {
	ANT_TASKS="none" eant -Dversion="${PV}" jars $(use_doc javadoc)
}

src_install() {
	java-pkg_newjar build/package/${PN}-${PV}.jar ${PN}.jar
	java-pkg_newjar build/package/${PN}-${PV}-contrib.jar ${PN}-contrib.jar

	use doc && java-pkg_dojavadoc build/apidocs
	use source && java-pkg_dosrc core/src/java/org contrib/src/java/org
}
