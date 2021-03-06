# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/hunterhacker/jdom.git"
EGIT_BRANCH="jdom-1.x"

JAVA_PKG_IUSE="source"

inherit base java-pkg-2 git-r3

DESCRIPTION="Jaxen binding for jdom."
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

COMMON_DEP="=dev-java/jdom-${PVR}*
		dev-java/jaxen:1.1
		dev-java/jaxen-jdom:1.1"
RDEPEND=">=virtual/jre-1.6
		${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
		${COMMON_DEP}"

java_prepare() {
	cd core
	sed -i -e 's/SAXPathException/Exception/g' src/java/org/jdom/xpath/JaxenXPath.java
}

src_compile() {
	cd core
	mkdir -p "${S}/core/build/org/jdom/xpath" || die "Unable to create dir."
	ejavac -d "${S}/core/build/" \
		-classpath $(java-config -p jdom,jaxen-1.1,jaxen-jdom-1.1) \
		src/java/org/jdom/xpath/JaxenXPath.java

	jar cf jdom-jaxen.jar -C build org || die "Failed to create jar."
}

src_install() {
	cd core
	java-pkg_dojar "${PN}.jar"
	use source && java-pkg_dosrc src/java/org
}
