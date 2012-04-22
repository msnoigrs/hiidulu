# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java command line options parser"
HOMEPAGE="http://args4j.kohsuke.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="1"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

java_prepare() {
	# This build.xml was first adapted for version 2.0.9, but should
	# apply to later versions as well. No need to change the version
	# number if the build system stayed the same. Please compare the
	# POMs you find at http://download.java.net/maven/1/args4j/poms/
	cp "${FILESDIR}/build-${PV}.xml" build.xml
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
