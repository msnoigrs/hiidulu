# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java API to manipulate XML data"
#SRC_URI="http://www.jdom.org/dist/source/${P}.tar.gz"
SRC_URI="http://www.jdom.org/dist/binary/archive/${P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="1.0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
#COMMON_DEP="dev-java/jaxen:1.1"
#	dev-java/xerces:2"
RDEPEND=">=virtual/jre-1.5"
#	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5"
#	${COMMON_DEP}"
PDEPEND="=dev-java/jdom-jaxen-${PVR}"
IUSE=""

S="${WORKDIR}/${PN}"

java_prepare() {
	rm -v build/*.jar lib/*.jar || die
	rm -rf build/{apidocs,samples} || die

	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
	   || die "Unable to remove Jaxen Binding class."

	cd ${S}/lib
#	java-pkg_jar-from xerces-2
#	java-pkg_jar-from jaxen-1.1 jaxen.jar jaxen-1.1.jar
}

src_compile() {
	# to prevent a newer jdom from going into cp
	# (EANT_ANT_TASKS doesn't work with none)
	ANT_TASKS="none" eant package $(use_doc)
}

src_install() {
	java-pkg_dojar build/*.jar

	java-pkg_register-dependency "jdom-jaxen-${SLOT}"
#	java-pkg_register-optional-dependency xerces-2

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}
