# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source doc"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/pdfbox/trunk/tools"
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="PDFBox tools"
HOMEPAGE="http://www.pdfbox.org"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND="dev-java/pdfbox
	dev-java/jcl-over-slf4j"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib pdfbox
	java-pkg_jar-from --into lib jcl-over-slf4j
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

my_launcher() {
	java-pkg_dolauncher ${1} --main org.apache.pdfbox.tools.${2} --jar pdfbox.jar
	echo "${1} -> ${2}" >> "${T}"/launcher.list
}

src_install() {
	java-pkg_dojar target/${PN}.jar

	my_launcher pdfdecompressobjectstreams DecompressObjectstreams
	my_launcher pdfdecrypt Decrypt
	my_launcher pdfencrypt Encrypt
	my_launcher pdfexportfdf ExportFDF
	my_launcher pdfexportxfdf ExportXFDF
	#my_launcher pdfextensionfilefilter ExtensionFileFilter
	my_launcher pdffextractimages ExtractImages
	my_launcher pdfextracttext ExtractText
	my_launcher pdfimportfdf ImportFDF
	my_launcher pdfimportxfdf ImportXFDF
	my_launcher pdfoverlaypdf OverlayPDF
	my_launcher pdfbox PDFBox
	my_launcher pdfdebugger PDFDebugger
	my_launcher pdfmerger PDFMerger
	my_launcher pdfreader PDFReader
	my_launcher pdfsplit PDFSplit
	#my_launcher pdftext2html PDFText2HTML
	my_launcher pdftoimage PDFToImage
	my_launcher pdfprintpdf PrintPDF
	my_launcher pdftexttopdf TextToPDF
	my_launcher pdfwritedecodeddoc WriteDecodedDoc

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
