# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Java command line options parser"
HOMEPAGE="http://args4j.kohsuke.org"
SRC_URI="http://maven.jenkins-ci.org/content/repositories/releases/args4j/args4j/2.0.21/args4j-2.0.21-sources.jar"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}"

src_unpack() {
	mkdir src || die
	cd src || die
	unpack ${A}
}

java_prepare() {
	# This build.xml was first adapted for version 2.0.9, but should
	# apply to later versions as well. No need to change the version
	# number if the build system stayed the same. Please compare the
	# POMs you find at http://download.java.net/maven/1/args4j/poms/
	cp "${FILESDIR}/build-${PV}.xml" build.xml
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/*
}
