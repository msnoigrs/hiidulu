# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/apache/pdfbox.git"
EGIT_BRANCH="trunk"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="An open source Java library for parsing font files"
HOMEPAGE="http://pdfbox.apache.org/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

COMMON_DEP="dev-java/jcl-over-slf4j:0"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	cd fontbox
	mkdir lib || die
	java-pkg_jar-from --into lib jcl-over-slf4j

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"
src_compile() {
	cd fontbox
	java-pkg-2_src_compile
}

src_install() {
	cd fontbox
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
