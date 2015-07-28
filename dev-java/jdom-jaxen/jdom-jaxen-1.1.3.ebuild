# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
JAVA_PKG_IUSE="source"

inherit base java-pkg-2

MY_PN="jdom"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Jaxen binding for jdom."
HOMEPAGE="http://www.jdom.org"
SRC_URI="http://www.jdom.org/dist/source/${MY_P}.tar.gz"
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

S="${WORKDIR}/${MY_PN}"

java_prepare() {
	sed -i -e 's/SAXPathException/Exception/g' src/java/org/jdom/xpath/JaxenXPath.java
}

src_compile() {
	mkdir -p "${S}/build/org/jdom/xpath" || die "Unable to create dir."
	ejavac -d "${S}/build/" \
		-classpath $(java-config -p jdom,jaxen-1.1,jaxen-jdom-1.1) \
		src/java/org/jdom/xpath/JaxenXPath.java

	jar cf jdom-jaxen.jar -C build org || die "Failed to create jar."
}

src_install() {
	java-pkg_dojar "${PN}.jar"
	use source && java-pkg_dosrc src/java/org
}
