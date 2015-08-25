# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 eutils java-ant-2

DESCRIPTION="A Java XPath Engine"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://dist.codehaus.org/${PN}/distributions/${P}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
PDEPEND="=dev-java/jaxen-dom4j-${PV}
	=dev-java/jaxen-jdom-${PV}
	=dev-java/jaxen-xom-${PV}"
DEPEND=">=virtual/jdk-1.6
	test? ( dev-java/ant-junit dev-java/junit:0 )"

java_prepare() {
	cp "${FILESDIR}/${PN}-build.xml" build.xml || die
	java-ant_ignore-system-classes

	cd "${S}/src/java/main"

	rm -rv org/w3c || die

	cd "${S}/src/java/main"
	rm -rv org/jaxen/dom4j || die
	rm -rv org/jaxen/jdom || die
	rm -rv org/jaxen/xom || die
}

src_install() {
	java-pkg_dojar target/${PN}.jar

#	java-pkg_register-dependency "jaxen-dom4j-${SLOT}"
#	java-pkg_register-dependency "jaxen-jdom-${SLOT}"
#	java-pkg_register-dependency "jaxen-xom-${SLOT}"

	use doc && java-pkg_dojavadoc dist/docs/api
	use examples && java-pkg_doexamples src/java/samples
	use source && java-pkg_dosrc src/java/main/*
}

src_test() {
	java-pkg_jar-from --into target/lib junit
	ANT_TASKS="ant-junit" eant test -DJunit.present=true
}
