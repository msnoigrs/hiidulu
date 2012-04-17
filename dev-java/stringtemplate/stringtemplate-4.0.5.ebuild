# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

MY_PV="${PV/_beta/b}"
S_PV="${PV/_beta/.b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A Java template engine"
HOMEPAGE="http://www.stringtemplate.org/"
SRC_URI="http://www.stringtemplate.org/download/ST-${PV}-src.zip"
LICENSE="BSD"
SLOT="4"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

#COMMON_DEPEND=">=dev-java/antlr-2.7.7:0[java]"
COMMON_DEPEND=">=dev-java/antlr-3.3:3.3
	dev-java/stringtemplate:0"

RDEPEND=">=virtual/jre-1.5
	${COMMON_DEPEND}"

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/junit:4 )
	${COMMON_DEPEND}"

S="${WORKDIR}/ST-${S_PV}"

java_prepare() {
	cp "${FILESDIR}/build-4.0.4.xml" build.xml
	cp "${FILESDIR}/STLexer.tokens" src/org/stringtemplate/v4/compiler
	find . -name "*.class" -print -delete || die "Failed deleting precompiled classes"
	find . -name "*.jar" -print -delete || die "Failed deleting prebuilt classes"
}

antlr2() {
	java -cp $(java-pkg_getjars antlr) antlr.Tool "${@}" || die "antlr2 failed"
}

antlr33() {
	java -cp $(java-pkg_getjars antlr-3.3,antlr,stringtemplate) org.antlr.Tool -o build/gen/org/stringtemplate/v4/compiler "${@}" || die "antlr3.3 failed"
}

src_compile() {
	einfo "Generate from grammars"
	cd src/org/stringtemplate/v4/compiler || die
	antlr33 Group.g
	antlr33 STParser.g
	antlr33 CodeGenerator.g

	cd ${S}
	EANT_BUILD_TARGET="build-jar" \
	EANT_EXTRA_ARGS="-Dantlr3.jar=$(java-pkg_getjar antlr-3.3 antlr3.jar)" \
	java-pkg-2_src_compile
#	cd "${S}" || die
#	find src -name "*.java" >> "${T}/sources" || die
#	ejavac -d target/classes -cp $(java-pkg_getjars antlr) "@${T}/sources"
#
#	# create javadoc
#	if use doc; then
#		javadoc -classpath $(java-pkg_getjars antlr) -d javadoc "@${T}/sources" || die "Javadoc failed"
#	fi
#
#	# jar things up
#	cd target/classes || die
#	find -type f >> "${T}/classes" || die
#	jar cf ${PN}.jar "@${T}/classes" || die "jar failed"
}

src_install() {
	java-pkg_newjar dist/ST*.jar ST.jar
	dodoc README.txt|| die
	use source && java-pkg_dosrc src/*
	#use doc && java-pkg_dojavadoc javadoc
}
