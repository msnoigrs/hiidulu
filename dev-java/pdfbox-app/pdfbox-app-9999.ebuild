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

CDEPEND="dev-java/fontbox:0
	dev-java/pdfbox:0
	dev-java/pdfbox-debugger:0
	dev-java/jcl-over-slf4j:0"
RDEPEND=">=virtual/jre-1.7
	dev-java/logback-core:0
	dev-java/logback-classic:0
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

java_prepare() {
	cd tools
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir "lib" || die
	cd "lib"

	java-pkg_jar-from pdfbox
	java-pkg_jar-from pdfbox-debugger
	java-pkg_jar-from fontbox
	java-pkg_jar-from jcl-over-slf4j
}
EANT_EXTRA_ARGS="-Dproject.name=${PN}"
src_compile() {
	cd tools
	java-pkg-2_src_compile
}

my_launcher() {
	  java-pkg_dolauncher ${1} --main org.apache.pdfbox.tools.${2} --jar pdfbox.jar
	  echo "${1} -> ${2}" >> "${T}"/launcher.list
}

src_install() {
	cd tools
	java-pkg_dojar target/${PN}.jar

	java-pkg_register-optional-dependency logback-core
	java-pkg_register-optional-dependency logback-classic

	my_launcher pdfbox PDFBox
	my_launcher exportfdf ExportFDF
	my_launcher exportxfdf ExportXFDF
	my_launcher importfdf ImportFDF
	my_launcher importxfdf ImportXFDF

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
