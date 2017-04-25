# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="jaxen"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Java XPath Engine for jdom classes"
HOMEPAGE="https://github.com/codehaus/jaxen"
SRC_URI="https://github.com/codehaus/jaxen/archive/V_1_1_6_Final.tar.gz -> ${MY_P}-src.tar.gz"

LICENSE="jaxen"
SLOT="1.1"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="=dev-java/jaxen-${PV}
	dev-java/jdom:0"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/${PN}-build.xml" build.xml || die
	java-ant_ignore-system-classes

	mkdir -p "${S}/target/lib"
	cd "${S}/target/lib"
	java-pkg_jar-from jaxen-1.1
	java-pkg_jar-from jdom

	cd "${S}/src/java/main"

	rm -rv org/w3c || die
	rm -v org/jaxen/*.java org/jaxen/*.html || die
	for d in dom expr function javabean pattern saxpath util dom4j xom
	do
		rm -rv "org/jaxen/${d}" || die
	done
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/main/*
}
