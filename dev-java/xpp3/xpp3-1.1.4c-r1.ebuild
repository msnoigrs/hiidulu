# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PV=${PV/m/.M}
MY_P=${PN}-${MY_PV}

DESCRIPTION="An implementation of XMLPULL V1 API."
HOMEPAGE="http://www.extreme.indiana.edu/xgws/xsoap/xpp/mxp1/index.html"
SRC_URI="http://www.extreme.indiana.edu/dist/java-repository/${PN}/distributions/${MY_P}_src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="test"

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit )"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	rm -v *.jar || die
	epatch "${FILESDIR}/${P}-build.xml.patch"
}

src_test() {
	ANT_TASKS="ant-junit" \
		eant -Dgentoo.classpath=$(java-pkg_getjars junit) junit_main
}

src_install() {
	java-pkg_newjar build/${MY_P}.jar ${PN}.jar

	dohtml doc/*.html || die
	dodoc doc/*.txt || die

	use doc && java-pkg_dojavadoc doc/api_impl
	use source && java-pkg_dosrc src/java/*
}
