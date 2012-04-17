# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/binary/${P}.zip"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="2"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
#	dev-java/xerces:2"
RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	dev-java/jaxen:1.1"
#PDEPEND="=dev-java/jdom-jaxen-${PVR}"
IUSE=""

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	mkdir -p src/java
	cd src/java
	jar xf ../../${P}-sources.jar

	rm -r org/jdom2/test
	rm -r org/jdom2/contrib
}

java_prepare() {
	cp "${FILESDIR}"/build-2.0.0.xml build.xml

	rm -v lib/*.jar || die

#	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
#	   || die "Unable to remove Jaxen Binding class."

	cd ${S}/lib
#	java-pkg_jar-from xerces-2
	java-pkg_jar-from --build-only jaxen-1.1
}

src_compile() {
	# to prevent a newer jdom from going into cp
	# (EANT_ANT_TASKS doesn't work with none)
	ANT_TASKS="none" eant jar $(use_doc)
}

src_install() {
	java-pkg_newjar build/${P}.jar

#	java-pkg_register-dependency "jdom-jaxen-${SLOT}"
#	java-pkg_register-optional-dependency xerces-2

#	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
#	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}
