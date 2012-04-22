# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils

MY_PN="jakarta-taglibs-standard"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="An implementation of the JSP Standard Tag Library (JSTL)"
HOMEPAGE="http://jakarta.apache.org/taglibs/doc/standard-doc/intro.html"
SRC_URI="mirror://apache/jakarta/taglibs/standard/source/${MY_P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/servlet-api:2.4
	dev-java/xalan"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
#	test? ( dev-java/ant-junit )
# FIXME breaks due to new JDBC API in 1.6
DEPEND=">=virtual/jdk-1.6
	=virtual/jdk-1.5*
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}-src/standard"

# Needs cactus packaged
# http://bugs.gentoo.org/show_bug.cgi?id=212890
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Remove unnecessary bootclasspath from javac calls.
	# This allows compilation with  non-Sun JDKs
	# See bug #134206
	# TODO file upstream
#	epatch "${FILESDIR}/build-xml.patch"
	#java-ant_remove-taskdefs build-tests.xml

	echo -e "base.dir=..\n" \
		"build.dir = \${base.dir}/build\n" \
		"build.classes=\${build.dir}/standard/standard/classes\n" \
		"dist.dir = \${base.dir}/dist\n" \
		"servlet24.jar=$(java-pkg_getjar --virtual servlet-api-2.4 servlet-api.jar)\n" \
		"jsp20.jar=$(java-pkg_getjar --virtual servlet-api-2.4 jsp-api.jar)\n" \
		"xalan.jar=$(java-pkg_getjar xalan xalan.jar)" \
		> build.properties
	#use test && echo "junit.jar=$(java-pkg_getjars --build-only junit)" >> build.properties
	java-pkg_filter-compiler jikes
}

src_compile() {
	local vm5=$(depend-java-query -v "=virtual/jdk-1.5*")
	local javac5=$(GENTOO_VM="${vm5}" java-config --javac)
	local home5=$(GENTOO_VM="${vm5}" java-config --jdk-home)"/jre"

	EANT_BUILD_TARGET="build" \
	EANT_DOC_TARGET="javadoc-dist" \
	EANT_TEST_TARGET="run.junit" \
	EANT_EXTRA_ARGS="-Djava.home=${home5}" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar "${S}"/../build/standard/standard/lib/*.jar

	use doc && java-pkg_dohtml -r "${S}"/doc/web/* "${S}"/../dist/standard/javadoc/
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc "${S}"/src/*
}
