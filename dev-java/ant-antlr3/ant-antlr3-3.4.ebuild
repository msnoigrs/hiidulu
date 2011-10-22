# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="antlr3 ant task"
HOMEPAGE="http://www.antlr.org/"
SRC_URI="http://www.antlr.org/download/antlr-${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/antlr:3.4"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	dev-libs/icu
	${COMMON_DEP}"

S="${WORKDIR}/antlr-${PV}/antlr-ant/main/antlr3-task"

JAVA_ANT_ENCODING="iso-8859-1"

java_prepare() {
	find "${WORKDIR}" -name '._*' -delete
	uconv --remove-signature antlr3-src/org/apache/tools/ant/antlr/antlib.xml -o ${T}/antlib.xml.nobom
	cp ${T}/antlib.xml.nobom antlr3-src/org/apache/tools/ant/antlr/antlib.xml
	cp "${FILESDIR}/gentoo-build.xml" build.xml
	mkdir lib || die
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
	java-pkg_jar-from --into lib antlr-3.4 antlr3.jar
}


EANT_EXTRA_ARGS="-Dproject.name=${PN}"

RESTRICT="test"

src_install() {
	java-pkg_dojar target/${PN}.jar

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
