# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

MY_PN="${PN##*-}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Ivy is a free java based dependency manager"
HOMEPAGE="http://ant.apache.org/ivy"
SRC_URI="http://www.jaya.free.fr/downloads/ivy/${PV}/${MY_P}-src.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/ant-core
	dev-java/commons-httpclient:3
	dev-java/commons-cli:1
	dev-java/commons-vfs
	dev-java/jakarta-oro:2.0
	dev-java/jsch"
DEPEND="
	>=virtual/jdk-1.6
	app-arch/unzip
	test? ( dev-java/ant-junit )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

JAVA_PKG_BSFIX="off"

java_prepare() {
	epatch "${FILESDIR}/1.4.1-javadoc.patch"

	# init-ivy expects existing ivy.jar, but we don't need actually it
	sed -i -e 's/depends="init-ivy, prepare"/depends="prepare"/' build.xml \
		|| die

	rm -v src/java/fr/jayasoft/ivy/repository/vfs/IvyWebdav* || die
	java-ant_bsfix_one build.xml
	java-ant_rewrite-classpath
	mkdir lib
}

src_compile() {
	local cp="$(java-pkg_getjar ant-core ant.jar)"
	cp="${cp}:$(java-pkg_getjars commons-httpclient-3)"
	cp="${cp}:$(java-pkg_getjars commons-vfs)"
	cp="${cp}:$(java-pkg_getjars commons-cli-1)"
	cp="${cp}:$(java-pkg_getjar jakarta-oro-2.0 jakarta-oro.jar)"
	cp="${cp}:$(java-pkg_getjars jsch)"

	eant -Dgentoo.classpath=${cp} -Dbuild.version=${PV} offline jar
}

src_test() {
	# TODO: find out why a couple of these fail
	java-pkg_jar-from --into lib junit
	ANT_TASKS="ant-junit" eant offline test
}

src_install() {
	java-pkg_dojar build/artifact/${MY_PN}.jar

	use doc && java-pkg_dojavadoc doc/ivy/api
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/java/*

	java-pkg_register-ant-task
}
