# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="jaxen"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Java XPath Engine for dom4j classes"
HOMEPAGE="http://jaxen.org/"
SRC_URI="http://dist.codehaus.org/${MY_PN}/distributions/${MY_P}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="=dev-java/jaxen-${PV}
	dev-java/dom4j:1"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/${P}-build.xml" build.xml || die
	java-ant_ignore-system-classes

	mkdir -p "${S}/target/lib"
	cd "${S}/target/lib"
	java-pkg_jar-from jaxen-1.1
	java-pkg_jar-from dom4j-1

	cd "${S}/src/java/main"

	rm -rv org/w3c || die
	rm -v org/jaxen/*.java org/jaxen/*.html || die
	for d in dom expr function javabean pattern saxpath util jdom xom
	do
		rm -rv "org/jaxen/${d}" || die
	done
}

src_install() {
	java-pkg_newjar target/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/main/*
}
