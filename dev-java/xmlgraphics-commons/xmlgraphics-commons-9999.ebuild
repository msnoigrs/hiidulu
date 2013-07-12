# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc examples source test"

ESVN_REPO_URI="http://svn.apache.org/repos/asf/xmlgraphics/commons/trunk"
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="A library of several reusable components used by Apache Batik and Apache FOP."
HOMEPAGE="http://xmlgraphics.apache.org/commons/index.html"
#SRC_URI="mirror://apache/xmlgraphics/commons/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="1.5"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="jpeg"

# fails connect to X even tho it sets java.awt.headless
RESTRICT="test"
CDEPEND="dev-java/commons-io:1
	dev-java/jcl-over-slf4j"
DEPEND=">=virtual/jdk-1.5
		test? (
			dev-java/ant-junit
		)
		${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
		${CDEPEND}"

# TODO investigate producing .net libraries
# stratigies for non sun jdk's/jre's

JAVA_ANT_ENCODING="iso-8859-1"
JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
JAVA_ANT_REWRITE_CLASSPATH="true"

java_prepare() {
	rm -v "${S}"/lib/*.jar || die
}

EANT_GENTOO_CLASSPATH="commons-io-1,jcl-over-slf4j"
EANT_EXTRA_ARGS="-Djdk15.present=true"
EANT_BUILD_TARGET="jar-main"
EANT_DOC_TARGET="javadocs"

src_compile() {
	java-pkg-2_src_compile $(use jpeg && echo -Dsun.jpeg.present=true)
}

src_test() {
	java-pkg_jarfrom --into lib junit
	# probably needs ${af} from src_compile, doesn't work anyway
	ANT_TASKS="ant-junit" eant -Djunit.present=true junit
}

src_install(){
	java-pkg_newjar build/${PN}-svn-trunk.jar
	use source && java-pkg_dosrc src/java/org
	use doc && java-pkg_dojavadoc build/javadocs
}
