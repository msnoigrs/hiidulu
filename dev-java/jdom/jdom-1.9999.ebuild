# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/hunterhacker/jdom.git"
EGIT_BRANCH="jdom-1.x"

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 git-r3

DESCRIPTION="Java API to manipulate XML data"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"
PDEPEND="=dev-java/jdom-jaxen-${PVR}"
IUSE=""

java_prepare() {
	cd core
	cp "${FILESDIR}"/build-1.1.3.xml build.xml

	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
	   || die "Unable to remove Jaxen Binding class."

	cd ${S}/lib
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

	java-pkg_register-dependency "jdom-jaxen"

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}
