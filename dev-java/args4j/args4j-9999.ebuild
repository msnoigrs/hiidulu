# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="git://github.com/kohsuke/args4j.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="Java command line options parser"
HOMEPAGE="http://args4j.kohsuke.org"
LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

java_prepare() {
	cd args4j
	cp "${FILESDIR}/build-${PV}.xml" build.xml
}

src_compile() {
	cd args4j
	java-pkg-2_src_compile
}

src_install() {
	cd args4j
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
