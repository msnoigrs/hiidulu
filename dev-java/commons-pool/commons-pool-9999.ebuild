# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source test"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/pool/trunk"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Jakarta-Commons component providing general purpose object pooling API"
HOMEPAGE="http://commons.apache.org/pool/"
#SRC_URI="mirror://apache/commons/pool/source/${P}-src.tar.gz"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	test? (
		dev-java/ant-junit
		dev-java/junit:0
	)"

S="${WORKDIR}/${P}-src"

EANT_BUILD_TARGET="build-jar"

src_test() {
	ANT_TASKS="ant-junit" eant -Dclasspath="$(java-pkg_getjars junit)" test
}

src_install() {
	java-pkg_newjar dist/${PN}2*.jar
	dodoc README.txt RELEASE-NOTES.txt || die

	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/org
}
