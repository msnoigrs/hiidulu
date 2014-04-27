# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source examples"

inherit java-pkg-2 java-ant-2

DESCRIPTION="An embedded compiler for run-time compilation purposes"
HOMEPAGE="http://janino.net/"
SRC_URI="http://janino.net/download/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="dev-java/ant-core:0"
RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${CDEPEND}"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	mkdir -p commons-compiler/src/main/java
	mkdir -p janino/src/main/java
	unzip -qq commons-compiler-src.zip -d commons-compiler/src/main/java || die unzip failed
	unzip -qq janino-src.zip -d janino/src/main/java || die unzip failed
	mv commons-compiler/src/main/java/org/codehaus/commons/compiler/samples .
}

java_prepare() {
	find -iname '*.jar' -delete || die

	mkdir janino/lib
	cd janino/lib
	java-pkg_jar-from --build-only ant-core ant.jar

	cp "${FILESDIR}/gentoo-build.xml" "${S}/commons-compiler/build.xml"
	cp "${FILESDIR}/gentoo-build.xml" "${S}/janino/build.xml"
}

src_compile() {
	mkdir dist

	cd "${S}/commons-compiler"
	eant -Dproject.name=commons-compiler $(use_doc)
	cd "${S}/janino"
	eant -Dproject.name=janino $(use_doc)
}

src_install() {
	java-pkg_dojar "dist/commons-compiler.jar"
	java-pkg_dojar "dist/${PN}.jar"

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc commons-compiler/target/site/javadoc
	use doc && java-pkg_dojavadoc janino/target/site/javadoc
	use source && java-pkg_dosrc commons-compiler/src/main/java/*
	use source && java-pkg_dosrc janino/src/main/java/*

	use examples && java-pkg_doexamples examples/
}
