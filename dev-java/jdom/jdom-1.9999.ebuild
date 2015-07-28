# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/hunterhacker/jdom.git"
EGIT_BRANCH="jdom-1.x"

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="Java API to manipulate XML data"
#SRC_URI="http://www.jdom.org/dist/binary/archive/${P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"
PDEPEND="=dev-java/jdom-jaxen-${PVR}"
IUSE=""

#S="${WORKDIR}/${PN}"

java_prepare() {
	cd core
	cp "${FILESDIR}"/build-1.1.3.xml build.xml

#	rm -v build/*.jar lib/*.jar || die
#	rm -rf build/{apidocs,samples} || die

	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
	   || die "Unable to remove Jaxen Binding class."

	cd ${S}/lib
#	java-pkg_jar-from xerces-2
#	java-pkg_jar-from jaxen-1.1 jaxen.jar jaxen-1.1.jar
}

src_compile() {
	cd core
	# to prevent a newer jdom from going into cp
	# (EANT_ANT_TASKS doesn't work with none)
	ANT_TASKS="none" eant jar $(use_doc)
}

src_install() {
	cd core
	java-pkg_newjar build/${PN}-1.1.3.jar

	java-pkg_register-dependency "jdom-jaxen-${SLOT}"
#	java-pkg_register-optional-dependency xerces-2

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}
