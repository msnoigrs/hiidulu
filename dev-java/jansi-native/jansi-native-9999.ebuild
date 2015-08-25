# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="git://github.com/fusesource/jansi-native.git"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="Builds the JNI libraries for the jansi project"
HOMEPAGE="http://jansi.fusesource.org/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

COMMON_DEP="dev-java/hawtjni-runtime"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

src_prepare() {
	mkdir lib
	java-pkg_jar-from --into lib hawtjni-runtime

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
