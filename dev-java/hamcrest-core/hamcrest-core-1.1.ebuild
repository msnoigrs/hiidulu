# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="source"
WANT_ANT_TASKS="dev-java/jarjar:1"

inherit java-pkg-2 java-ant-2

MY_PN="hamcrest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library of matchers for building test expressions."
HOMEPAGE="http://code.google.com/p/${MY_PN}/"
SRC_URI="http://${MY_PN}.googlecode.com/files/${MY_P}.tgz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	dev-java/qdox:1.12"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	find -name "*.jar" -delete || die

#	epatch "${FILESDIR}/1.1-qdox-fix.patch"

	# These jars must be symlinked as specifying them using gentoo.classpath
	# does not work and both compilation and test fail
	java-pkg_jar-from --into lib/generator --build-only qdox-1.12 qdox.jar qdox-1.6.1.jar
}

EANT_BUILD_TARGET="core"
EANT_EXTRA_ARGS="-Dversion=${PV}"

src_install() {
	java-pkg_newjar build/${P}.jar
	java-pkg_newjar build/hamcrest-generator-1.1.jar hamcrest-generator.jar
	java-pkg_register-ant-task

	dodoc README.txt CHANGES.txt || die

	use source && java-pkg_dosrc ${PN}/src/main/java/org
}
