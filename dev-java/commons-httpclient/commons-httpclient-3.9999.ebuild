# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc examples source test"

ESVN_REPO_URI="https://svn.apache.org/repos/asf/httpcomponents/oac.hc3x/trunk/"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="The Jakarta Commons HttpClient library"
HOMEPAGE="http://hc.apache.org/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="3"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""
# doesn't work on IBM JDK, bug #176133
RESTRICT="test"

#	dev-java/commons-logging
COMMON_DEPEND="
	dev-java/jcl-over-slf4j
	dev-java/commons-codec"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit:0 )
	${COMMON_DEPEND}"

JAVA_ANT_ENCODING="iso-8859-1"

java_prepare() {
	# the generated docs go to docs/api
	rm -rf docs/apidocs

	# don't do javadoc always
	sed -i -e 's/depends="compile,doc"/depends="compile"/' build.xml || die
	sed -i -e '/link/ d' build.xml || die
	mkdir lib && cd lib
	java-pkg_jar-from jcl-over-slf4j jcl-over-slf4j.jar commons-logging.jar
#	java-pkg_jar-from commons-logging
	java-pkg_jar-from commons-codec
	java-pkg_filter-compiler jikes
}

EANT_BUILD_TARGET="dist"
EANT_DOC_TARGET="doc"

src_test() {
	java-pkg_jar-from --into lib junit
	eant test
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	# contains both html docs and javadoc in correct subdir
	if use doc ; then
		java-pkg_dojavadoc dist/docs/api
		java-pkg_dohtml -r dist/docs/*
	fi
	use source && java-pkg_dosrc src/java/*
	use examples && java-pkg_doexamples src/examples
}
