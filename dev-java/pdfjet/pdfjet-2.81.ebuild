# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESRIPTION="A library for dynamic generation of PDF documents from Java"
HOMEPAGE="http://pdfjet.com/index.html"
SRC_URI="http://pdfjet.com/PDFjet-OS-v2.81.zip"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/PDFjet-OS-v${PV}"

java_prepare() {
	# remove C# source files
	rm -rv net
	rm -rv docs/c-sharp

	mkdir -p src/main/java
	mv com src/main/java

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
