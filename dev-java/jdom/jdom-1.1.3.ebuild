# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java API to manipulate XML data"
#SRC_URI="http://www.jdom.org/dist/source/${P}.tar.gz"
SRC_URI="http://www.jdom.org/dist/binary/archive/${P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"
PDEPEND="=dev-java/jdom-jaxen-${PVR}"
IUSE=""

S="${WORKDIR}/${PN}"

java_prepare() {
	cp "${FILESDIR}"/build-1.1.3.xml build.xml

	rm -v build/*.jar lib/*.jar || die
	rm -rf build/{apidocs,samples} || die

	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
	   || die "Unable to remove Jaxen Binding class."
}

src_compile() {
	# to prevent a newer jdom from going into cp
	# (EANT_ANT_TASKS doesn't work with none)
	ANT_TASKS="none" eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar build/${P}.jar

	java-pkg_register-dependency "jdom-jaxen"

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}
