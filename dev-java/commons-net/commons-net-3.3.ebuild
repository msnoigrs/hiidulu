# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

RESTRICT="test"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_P="${P}-src"

DESCRIPTION="Jakarta Commons Net implements the client side of many basic Internet protocols."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI="mirror://apache/commons/net/source/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"
#	dev-java/maven-ant-helper"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/main/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/main/java/org
}
