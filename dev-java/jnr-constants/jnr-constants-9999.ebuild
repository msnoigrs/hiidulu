# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source test"

EGIT_REPO_URI="git://github.com/jnr/jnr-constants.git"

WANT_ANT_TASKS="ant-nodeps"

inherit base java-pkg-2 java-ant-2 git-2

DESCRIPTION="Provides Java values for common platform C constants"
HOMEPAGE="http://github.com/jnr/jnr-constants"
#SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/jre-1.5"

DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit4 )"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml
}

src_compile() {
	# ecj doesn't like some cast for some reason
	java-pkg_force-compiler javac
	EANT_EXTRA_ARGS="-Dproject.name=${PN}" \
	java-pkg-2_src_compile
}

src_install() {
	#java-pkg_dojar dist/${PN}.jar
	#use source && java-pkg_dosrc src/*

	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}

src_test() {
	ANT_TASKS="ant-junit4" eant test -Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)"
}
