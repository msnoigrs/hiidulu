# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc examples source"

inherit subversion java-pkg-2 java-ant-2

ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/net/trunk"

DESCRIPTION="Jakarta Commons Net implements the client side of many basic Internet protocols."
HOMEPAGE="http://jakarta.apache.org/commons/net/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org

	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -r src/main/java/examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/java/org
}
