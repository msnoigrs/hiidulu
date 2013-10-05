# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/pdfbox/trunk/pdfbox"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Java library and utilities for working with PDF documents"
HOMEPAGE="http://www.pdfbox.org"
#SRC_URI="pcfi-2009.06.14.jar additional_cmaps.jar removed_cmaps.jar"
#SRC_URI="https://github.com/masayuko/hiidulu/raw/master/distfiles/pcfi-2010.08.09.jar"
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/pcfi-2010.08.09.jar"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

#	dev-java/lucene:2.4
#>=dev-java/tika-core-0.10
CDEPEND="dev-java/fontbox
	dev-java/jempbox
	dev-java/bcprov:0
	dev-java/bcmail:0
	dev-java/bcpkix:0
	dev-java/jcl-over-slf4j
	dev-java/icu4j:0"
RDEPEND=">=virtual/jre-1.6
	dev-java/logback-core
	dev-java/logback-classic
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.6
	dev-java/junit:4
	${CDEPEND}"

JAVA_PKG_FILTER_COMPILER="jikes"
#S="${WORKDIR}/${ECVS_MODULE}"

# missing needed files
RESTRICT="test"

java_prepare() {
	#epatch "${FILESDIR}/defaultfontwidth.patch"
	#epatch "${FILESDIR}/identity-h.patch"

#	cp "${FILESDIR}/gentoo-build.xml" build.xml
	sed -i -e 's/depends="get.externallibs.pdfbox,/depends="/' build.xml
	sed -i -e 's/depends="fontbox.package,jempbox.package,/depends="/' build.xml

	mkdir external || die
	cd external
#	java-pkg_jar-from tika-core tika-core.jar tika-core-0.10.jar
	java-pkg_jar-from fontbox fontbox.jar
	java-pkg_jar-from jempbox jempbox.jar
	java-pkg_jar-from bcprov bcprov.jar bcprov-jdk15-1.48.jar
	java-pkg_jar-from bcmail bcmail.jar bcmail-jdk15-1.48.jar
	java-pkg_jar-from bcpkix bcpkix.jar bcpkix-jdk15-1.48.jar
#	java-pkg_jar-from lucene-2.4 lucene-core.jar lucene-core-2.4.1.jar
#	java-pkg_jar-from lucene-2.4 lucene-demos.jar lucene-dmoes-2.4.1.jar
#	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from --build-only junit junit.jar junit-4.8.1.jar
	java-pkg_jar-from jcl-over-slf4j jcl-over-slf4j.jar commons-logging-1.1.1.jar
	java-pkg_jar-from icu4j-49 icu4j.jar icu4j-3.8.jar

	cd ${S}
#	mkdir download || die
	cp ${DISTDIR}/*.jar download

	rm -rf src/test/java/org
}

EANT_EXTRA_ARGS="-Dfontbox.jar=external/fontbox.jar -Djempbox.jar=external/jempbox.jar"
EANT_BUILD_TARGET="pdfbox.package"

my_launcher() {
	java-pkg_dolauncher ${1} --main org.apache.pdfbox.${2} --jar pdfbox.jar
	echo "${1} -> ${2}" >> "${T}"/launcher.list
}

src_install() {
	java-pkg_newjar target/${PN}-*.jar
	java-pkg_dojar download/pcfi-2010.08.09.jar
#	java-pkg_dojar download/additional_cmaps.jar
#	java-pkg_dojar download/removed_cmaps.jar

	java-pkg_register-optional-dependency logback-core
	java-pkg_register-optional-dependency logback-classic

	my_launcher pdfconvertcolorspace ConvertColorspace
	my_launcher pdfdecrypt Decrypt
	my_launcher pdfencrypt Encrypt
	my_launcher pdfexportfdf ExportFDF
	my_launcher pdfexportxfdf ExportXFDF
	my_launcher pdfextractimages ExtractImages
	my_launcher pdfextracttext ExtractText
	my_launcher pdfimportfdf ImportFDF
	my_launcher pdfimportxfdf ImportXFDF
	my_launcher pdfoverlay Overlay
	my_launcher pdfdebugger PDFDebugger
	my_launcher pdfmerger PDFMerger
	my_launcher pdfreader PDFReader
	my_launcher pdfsplit PDFSplit
	my_launcher pdftoimage PDFToImage
	my_launcher printpdf PrintPDF
	my_launcher texttopdf TextToPDF

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}

pkg_postinst() {
	elog "This package installs several command line tools for manipulating"
	elog "PDF files. Some of their names were changed from upstream to"
	elog "be less ambigous, and not collide with other packages. For"
	elog "detailed information refer to the html documentation installed with"
	elog "USE=doc, or ${HOMEPAGE}"

	while read line
	do
		elog ${line}
	done < "${T}"/launcher.list
}
