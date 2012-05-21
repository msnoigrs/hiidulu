# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source test"

EGIT_REPO_URI="git://github.com/amplafi/htmlcleaner.git"
#ESVN_REPO_URI="https://htmlcleaner.svn.sourceforge.net/svnroot/htmlcleaner"

#inherit java-pkg-2 java-ant-2 subversion
inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION=""
HOMEPAGE="http://htmlcleaner.sourceforge.net/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

COMMON_DEP="dev-java/jdom:1.0"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	test? ( dev-java/junit )"

RESTRICT="test"

src_prepare() {
	#rm -v lib/*.jar || die
	mkdir lib || die
	rm -rf src/test

	java-pkg_jar-from --into lib --build-only ant-core ant.jar
	java-pkg_jar-from --into lib jdom-1.0
}

src_install() {
	java-pkg_newjar ${S}/${PN}2_1.jar ${PN}.jar
	java-pkg_dolauncher "${PN}" --main org.htmlcleaner.CommandLine
}
