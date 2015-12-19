# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="https://github.com/neolefty/ditaa.git"

JAVA_PKG_IUSE="source doc"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="DIagrams Through Ascii Art"
HOMEPAGE="http://ditaa.sourceforge.net/"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEP="dev-java/batik:1.8
	dev-java/jericho-html:0
	dev-java/commons-cli:1
	dev-java/xml-commons-external:1.4"
DEPEND=">=virtual/jdk-1.7
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.7
	${COMMON_DEP}"

java_prepare() {
	rm -r src/org/stathissideris/ascii2image/test
	rm src/org/stathissideris/ascii2image/core/JavadocTaglet.java

	rm lib/*.jar

	java-pkg_jar-from --into lib batik-1.8 batik-all.jar
	java-pkg_jar-from --into lib jericho-html
	java-pkg_jar-from --into lib commons-cli-1
	java-pkg_jar-from --into lib xml-commons-external-1.4 xml-apis-ext.jar

	sed -i -e 's/org.apache.batik.ext.awt.image.codec.PNGEncodeParam/org.apache.batik.ext.awt.image.codec.png.PNGEncodeParam/' \
		-e 's/org.apache.batik.ext.awt.image.codec.PNGImageEncoder/org.apache.batik.ext.awt.image.codec.png.PNGImageEncoder/' \
		src/org/stathissideris/ascii2image/graphics/ImageHandler.java

	sed -i -e 's/org.apache.batik.dom.svg.SAXSVGDocumentFactory/org.apache.batik.anim.dom.SAXSVGDocumentFactory/' src/org/stathissideris/ascii2image/graphics/ImageHandler.java
	sed -i -e 's/org.apache.batik.dom.svg.SAXSVGDocumentFactory/org.apache.batik.anim.dom.SAXSVGDocumentFactory/' src/org/stathissideris/ascii2image/graphics/OffScreenSVGRenderer.java

	cp "${FILESDIR}"/gentoo-build.xml build.xml
}

#JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	java-pkg_dolauncher ${PN} --main org.stathissideris.ascii2image.core.CommandLineConverter

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
