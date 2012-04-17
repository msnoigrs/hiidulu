# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

ECVS_SERVER="gee.cs.oswego.edu/home/jsr166/jsr166"
ECVS_MODULE="jsr166"

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2 cvs

DESCRIPTION="Collections supporting parallel operations."
HOMEPAGE="http://g.oswego.edu/dl/concurrency-interest/"
SRC_URI=""

LICENSE="CC0-1.0-Universal"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

COMMON_DEP="dev-java/jsr166y"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/jsr166"

EANT_BUILD_TARGET="extra166yjar"
EANT_DOC_TARGET="extra166ydocs"

src_prepare() {
	find . -depth -name 'CVS' -exec rm -rf {} :

	mkdir -p build/jsr166ylib
	java-pkg_jar-from --into build/jsr166ylib jsr166y
}

src_install() {
	java-pkg_dojar build/extra166ylib/${PN}.jar

	use doc && java-pkg_dojavadoc build/extra166yjavadocs
	use source && java-pkg_dosrc src/extra166y
}
