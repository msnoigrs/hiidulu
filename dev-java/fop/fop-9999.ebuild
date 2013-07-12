# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO: if 'doc' use flag is used then should build also extra docs ('docs' ant target), currently it cannot
#       be built as it needs forrest which we do not have
# TODO: package and use optional dependency jeuclid

EAPI="4"
JAVA_PKG_IUSE="doc examples source"
WANT_ANT_TASKS="ant-trax"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/xmlgraphics/fop/trunk"
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Formatting Objects Processor is a print formatter driven by XSL"
HOMEPAGE="http://xmlgraphics.apache.org/fop/"
#SRC_URI="mirror://apache/xmlgraphics/${PN}/source/${P}-src.zip"
LICENSE="Apache-2.0"
SLOT="0"
# doesn't work with java.awt.headless
RESTRICT="test"
KEYWORDS="amd64 ppc ppc64 x86"
#IUSE="hyphenation jai"
IUSE="hyphenation"

COMMON_DEPEND="
	dev-java/avalon-framework:4.2
	dev-java/batik:1.7
	dev-java/commons-io:1
	dev-java/jcl-over-slf4j
	dev-java/xmlgraphics-commons:1.5
	dev-java/xml-commons-external:1.4
	dev-java/xalan:0
	dev-java/slf4j-api
	dev-java/logback-core
	dev-java/logback-classic"
#	jai? ( dev-java/jai-core )"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.5
	java-virtuals/servlet-api:3.0
	hyphenation? ( dev-java/offo-hyphenation )
	${COMMON_DEPEND}"
#	test? (
#		=dev-java/junit-3.8*
#		dev-java/xmlunit
#	)"

java_prepare() {
	# automagic is bad
	java-ant_ignore-system-classes || die

	cd "${S}/lib"
	rm -v *.jar || die

	java-pkg_jar-from --build-only ant-core ant.jar
	java-pkg_jar-from avalon-framework-4.2
	java-pkg_jar-from batik-1.7
	java-pkg_jar-from commons-io-1
#	java-pkg_jarfrom commons-logging commons-logging.jar \
#		commons-logging-1.0.4.jar
	java-pkg_jar-from jcl-over-slf4j
	java-pkg_jarfrom --build-only --virtual servlet-api-3.0
	java-pkg_jar-from xmlgraphics-commons-1.5
	java-pkg_jar-from xalan xalan.jar
	java-pkg_jar-from xml-commons-external-1.4
	java-pkg_jar-from slf4j-api
	java-pkg_jar-from logback-core
	java-pkg_jar-from logback-classic

#	use jai && java-pkg_jar-from jai-core
#	use jimi && java-pkg_jar-from sun-jimi
}

EANT_DOC_TARGET="javadocs"
EANT_BUILD_TARGET="package"

src_compile() {
	# because I killed the automagic tests; all our JDK's have JCE
	local af="-Djdk14.present=true -Djce.present=true"
	use hyphenation && af="${af} -Duser.hyph.dir=/usr/share/offo-hyphenation/hyph/"
	use jai && af="${af} -Djai.present=true"

	export ANT_OPTS="-Xmx256m"
#	java-pkg-2_src_compile ${af} -Djavahome.jdk14="${JAVA_HOME}"
	java-pkg-2_src_compile ${af}
}

src_test() {
	java-pkg_jar-from --into lib xmlunit-1
	java-pkg_jar-from --into lib junit

	ANT_OPTS="-Xmx1g -Djava.awt.headless=true" eant -Djunit.fork=off junit
}

src_install() {
	java-pkg_dojar build/fop.jar build/fop-sandbox.jar
	if use hyphenation; then
		java-pkg_dojar build/fop-hyph.jar
		insinto /usr/share/${PN}/
		doins -r hyph || die
	fi

	# doesn't support everything upstream launcher does...
	java-pkg_dolauncher ${PN} --main org.apache.fop.cli.Main

	dodoc NOTICE README || die

	use doc && java-pkg_dojavadoc build/javadocs
	use examples && java-pkg_doexamples examples/* conf
	use source && java-pkg_dosrc src/java/org src/sandbox/org
}

pkg_postinst(){
	elog "The SVG Renderer and the MIF Handler have not been resurrected"
	elog "They are currently non-functional."
	elog
	elog "The API of FOP has changed considerably and is not backwards-compatible"
	elog "with versions 0.20.5 and 0.91beta. Version 0.92 introduced the new"
	elog "stable API."
}
