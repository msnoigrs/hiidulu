# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

ECVS_SERVER="jena.cvs.sourceforge.net:/cvsroot/jena"
ECVS_MODULE="iri"

inherit cvs java-pkg-2 java-ant-2

DESCRIPTION="an implementation of RFC 3987 (IRI) and RFC 3986 (URI)"
HOMEPAGE="http://jena.sourceforge.net/iri/index.html"
SRC_URI=""

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

COMMON_DEP="dev-java/icu4j:49"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

java_prepare() {
	rm -v lib/*.jar
	rm -v lib-build/*.jar

	find -depth -name CVS -exec rm -rf {} +

	java-pkg_jar-from --into lib icu4j-49 icu4j.jar

	mkdir bin-build
	mkdir -p doc/javadoc
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_BUILD_TARGET="build"

src_compile() {
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar lib/iri.jar

	use doc && java-pkg_dojavadoc doc/javadoc
	use source && java-pkg_dosrc src/com
}
