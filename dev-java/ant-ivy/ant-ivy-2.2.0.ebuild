# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="apache-ivy"
MY_P=${MY_PN}-${PV}

DESCRIPTION="Ivy is a free java based dependency manager"
HOMEPAGE="http://ant.apache.org/ivy"
SRC_URI="mirror://apache/ant/ivy/${PV}/${MY_P}-src.zip"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/ant-core
	dev-java/commons-httpclient:3
	dev-java/commons-vfs
	dev-java/jakarta-oro:2.0
	dev-java/jsch
	dev-java/bcprov
	dev-java/bcpg"
DEPEND="
	>=virtual/jdk-1.5
	app-arch/unzip
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S=${WORKDIR}/${MY_P}

# Rewrites examples... bad
JAVA_PKG_BSFIX="off"

java_prepare() {
	java-ant_bsfix_one build.xml
	java-ant_bsfix_one src/java/org/apache/ivy/plugins/resolver/packager/build.xml
	java-ant_rewrite-classpath build.xml

	mkdir -p ${S}/lib || die
}

src_compile() {
	local cp="$(java-pkg_getjar --build-only ant-core ant.jar)"
	cp="${cp}:$(java-pkg_getjars commons-httpclient-3)"
	cp="${cp}:$(java-pkg_getjars commons-vfs)"
	cp="${cp}:$(java-pkg_getjar jakarta-oro-2.0 jakarta-oro.jar)"
	cp="${cp}:$(java-pkg_getjars jsch)"
	cp="${cp}:$(java-pkg_getjars bcprov)"
	cp="${cp}:$(java-pkg_getjars bcpg)"
#	eant -Dgentoo.classpath=${cp} -Dtarget.ivy.bundle.version=${PV} /offline /noresolve /notest /localivy jar
	eant -Dgentoo.classpath=${cp} -Dtarget.ivy.version=${PV} /offline /noresolve /notest /localivy jar
}

src_install() {
	java-pkg_dojar build/artifact/jars/ivy.jar
#	use doc && java-pkg_dojavadoc doc/build/api
	use doc && java-pkg_dojavadoc doc
	use source && java-pkg_dosrc src/java/*

	java-pkg_register-ant-task
}

RESTRICT="test" # fail because of a missing file

src_test() {
	java-pkg_jar-from --into lib junit
	ANT_TASKS="ant-junit" eant test || die "Junit tests failed"
}
