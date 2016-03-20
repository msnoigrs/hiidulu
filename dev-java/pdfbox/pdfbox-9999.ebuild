# Copyright 1999-2016 Gentoo Foundation
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
	dev-java/bcprov:1.52
	dev-java/bcpkix:1.52
	dev-java/jcl-over-slf4j:0"
#	dev-java/java-diff-utils:0"
RDEPEND=">=virtual/jre-1.7
	dev-java/logback-core:0
	dev-java/logback-classic:0
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.7
	dev-java/junit:4
	${CDEPEND}"

java_prepare() {
	cd pdfbox
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir "lib" || die
	cd "lib"

	java-pkg_jar-from fontbox fontbox.jar
	java-pkg_jar-from bcprov-1.52 bcprov.jar
	java-pkg_jar-from bcpkix-1.52 bcpkix.jar
	#java-pkg_jar-from java-diff-utils

	java-pkg_jar-from --build-only junit junit.jar
	java-pkg_jar-from jcl-over-slf4j jcl-over-slf4j.jar
}
EANT_EXTRA_ARGS="-Dproject.name=${PN}"
src_compile() {
	cd pdfbox
	java-pkg-2_src_compile
}

src_install() {
	cd pdfbox
	java-pkg_dojar target/${PN}.jar

	java-pkg_register-optional-dependency logback-core
	java-pkg_register-optional-dependency logback-classic

#	my_launcher pdfconvertcolorspace ConvertColorspace
#	my_launcher pdfdecrypt Decrypt
#	my_launcher pdfencrypt Encrypt
#	my_launcher pdfexportfdf ExportFDF
#	my_launcher pdfexportxfdf ExportXFDF
#	my_launcher pdfextractimages ExtractImages
#	my_launcher pdfextracttext ExtractText
#	my_launcher pdfimportfdf ImportFDF
#	my_launcher pdfimportxfdf ImportXFDF
#	my_launcher pdfoverlay Overlay
#	my_launcher pdfdebugger PDFDebugger
#	my_launcher pdfmerger PDFMerger
#	my_launcher pdfreader PDFReader
#	my_launcher pdfsplit PDFSplit
#	my_launcher pdftoimage PDFToImage
#	my_launcher printpdf PrintPDF
#	my_launcher texttopdf TextToPDF

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
