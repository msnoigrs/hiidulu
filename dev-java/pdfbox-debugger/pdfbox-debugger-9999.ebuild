# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/apache/pdfbox.git"
EGIT_BRANCH="trunk"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="Java library and utilities for working with PDF documents"
HOMEPAGE="http://www.pdfbox.org"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

CDEPEND="dev-java/pdfbox:0"
RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

java_prepare() {
	cd debugger
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir "lib" || die
	cd "lib"

	java-pkg_jar-from pdfbox
}
EANT_EXTRA_ARGS="-Dproject.name=${PN}"
src_compile() {
	cd debugger
	java-pkg-2_src_compile
}

src_install() {
	cd debugger
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
