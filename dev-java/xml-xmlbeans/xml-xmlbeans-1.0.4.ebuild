# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="An XML-Java binding tool"
HOMEPAGE="http://xmlbeans.apache.org/"
SRC_URI="mirror://apache/xmlbeans/source/xmlbeans-${PV}-src.tgz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEP="dev-java/jaxen:1.1
	dev-java/ant-core"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/xmlbeans-${PV}"

java_prepare() {
	rm -v external/lib/jaxen*jar
	java-pkg_jar-from --into external/lib jaxen-1.1 jaxen.jar jaxen-1.1-beta-2.jar
}

JAVA_ANT_REWRITE_CLASSPATH="yes"
EANT_BUILD_TARGET="xbean.jar"
EANT_DOC_TARGET="docs"
JAVA_ANT_ENCODING="iso-8859-1"

src_compile() {
	EANT_EXTRA_ARGS="-Dgentoo.classpath=$(java-pkg_getjar ant-core ant.jar)" \
	java-pkg-2_src_compile
}

# Tests always seem to fail #100895

src_install() {
	java-pkg_dojar build/lib/xbean*.jar

	dodoc CHANGES.txt NOTICE.txt README.txt
	if use doc; then
		java-pkg_dojavadoc build/docs/reference
		java-pkg_dohtml -r docs
	fi
	use source && java-pkg_dosrc src/*
}
