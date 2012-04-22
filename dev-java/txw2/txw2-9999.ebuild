# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/jaxb~version2/trunk/txw2"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="TXW is a library that allows you to write XML documents."
HOMEPAGE="https://txw.dev.java.net/"
#SRC_URI="https://txw.dev.java.net/files/documents/3310/54821/txw2-${PV}.zip"
SRC_URI=""

LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/xsom:0
	dev-java/rngom:0
	dev-java/codemodel:2
	dev-java/args4j:1
	dev-java/relaxng-datatype:0
	java-virtuals/stax-api"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" runtime/build.xml || die
	cp "${FILESDIR}/gentoo-build.xml" compiler/build.xml || die

	mkdir -p runtime/lib
	java-pkg_jar-from --into runtime/lib --virtual stax-api
	mkdir -p compiler/lib
	java-pkg_jar-from --into compiler/lib --build-only ant-core ant.jar
	java-pkg_jar-from --into compiler/lib codemodel-2
	java-pkg_jar-from --into compiler/lib rngom
	java-pkg_jar-from --into compiler/lib xsom
	java-pkg_jar-from --into compiler/lib args4j-1
	java-pkg_jar-from --into compiler/lib relaxng-datatype
}

src_compile() {
	cd ${S}/runtime
	EANT_EXTRA_ARGS="-Dproject.name=txw2" \
		java-pkg-2_src_compile
	cp ${S}/runtime/target/txw2.jar ${S}/compiler/lib || die
	cd ${S}/compiler
	EANT_EXTRA_ARGS="-Dproject.name=txwc2" \
		java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar runtime/target/txw2.jar
	java-pkg_dojar compiler/target/txwc2.jar

	java-pkg_register-ant-task

	java-pkg_dolauncher txwc2 --main "com.sun.tools.txw2.Main"

	use doc && java-pkg_dojavadoc build/javadoc
	if use source; then
		java-pkg_dosrc compiler/src/main/java/*
		java-pkg_dosrc runtime/src/main/java/*
	fi
}
