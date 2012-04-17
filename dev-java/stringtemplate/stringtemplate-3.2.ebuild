# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-antlr"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java template engine"
HOMEPAGE="http://www.stringtemplate.org/"
SRC_URI="http://www.stringtemplate.org/download/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# no junit targets in build.xml, but unconditional compile and jar of test
# classes, oh well
COMMON_DEPEND="dev-java/antlr:0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEPEND}"

#	test? ( dev-java/junit:0 )"

java_prepare() {
	# fix <javadoc> call
	epatch "${FILESDIR}/${P}-javadoc.patch"
	java-ant_rewrite-classpath
	rm -v lib/*.jar || die
	# remove junit dependency
	rm -rv src/org/antlr/stringtemplate/test
	# force regeneration with our antlr2
	touch src/org/antlr/stringtemplate/language/*.g || die
}

#EANT_GENTOO_CLASSPATH="antlr,junit"
EANT_GENTOO_CLASSPATH="antlr"
EANT_DOC_TARGET="javadocs"

src_install() {
	java-pkg_dojar build/${PN}.jar

	dodoc README.txt || die
	if use doc; then
		java-pkg_dojavadoc docs/api
		dohtml -r doc/* || die
	fi
	use source && java-pkg_dosrc src/org
}
