# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="istack-commons"
HOMEPAGE="https://istack-commons.dev.java.net/"
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/istack-commons-${PV}.tar.gz"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="java-virtuals/jaf"

DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/build-common.xml" "${S}"
	cp "${FILESDIR}/tools-build.xml" "${S}/tools/build.xml"
	java-ant_bsfix_one build-common.xml

	rm -v runtime/lib/*.jar

	rm -rv runtime/src/test
	rm -rv tools/src/test

	java-pkg_jar-from --into runtime/lib --virtual jaf

	cp ${S}/tools/src14/com/sun/istack/tools/ProtectedTask.java \
		${S}/tools/src/main/java/com/sun/istack/tools
	#sed -i -e 's/srcdir="src14"/srcdir="src"/' ${S}/tools/build.xml
	mkdir -p "${S}/tools/lib" || die
	ln -s $(java-config --tools) "${S}/tools/lib" || die
	java-pkg_jar-from --into ${S}/tools/lib --build-only ant-core ant.jar
}

src_compile() {
	EANT_BUILD_XML="runtime/build.xml"
	java-pkg-2_src_compile
	EANT_BUILD_XML="tools/build.xml"
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar runtime/build/istack-commons-runtime.jar
	java-pkg_dojar tools/build/istack-commons-tools.jar
	java-pkg_register-ant-task
	if use source; then
		java-pkg_dosrc runtime/src/*
		java-pkg_dosrc tools/src/*
	fi
}