# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="https://github.com/purcell/jargs.git"

JAVA_PKG_IUSE="source doc"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="command line option parsers"
HOMEPAGE="http://jargs.sourceforge.net/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP=""
DEPEND=">=virtual/jdk-1.7
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}"/gentoo-build.xml build.xml
}

#JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
