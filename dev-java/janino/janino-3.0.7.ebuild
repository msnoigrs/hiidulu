# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/janino-compiler/janino.git"
EGIT_BRANCH="3.0.7"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="An embedded compiler for run-time compilation purposes"
HOMEPAGE="https://janino-compiler.github.io/janino/"

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

java_prepare() {
	cd janino/lib
	java-pkg_jar-from --build-only ant-core ant.jar

	cp "${FILESDIR}/gentoo-build.xml" "${S}/commons-compiler/build.xml"
	cp "${FILESDIR}/gentoo-build.xml" "${S}/commons-compiler-jdk/build.xml"
	cp "${FILESDIR}/gentoo-build.xml" "${S}/janino/build.xml"
}

src_compile() {
	mkdir dist

	cd "${S}/commons-compiler"
	eant -Dproject.name=commons-compiler $(use_doc)
	cd "${S}/commons-compiler-jdk"
	eant -Dproject.name=commons-compiler-jdk $(use_doc)
	cd "${S}/janino"
	eant -Dproject.name=janino $(use_doc)
}

src_install() {
	java-pkg_dojar "dist/commons-compiler.jar"
	java-pkg_dojar "dist/commons-compiler-jdk.jar"
	java-pkg_dojar "dist/${PN}.jar"

	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc commons-compiler/target/site/javadoc
	use doc && java-pkg_dojavadoc commons-compiler-jdk/target/site/javadoc
	use doc && java-pkg_dojavadoc janino/target/site/javadoc
	use source && java-pkg_dosrc commons-compiler/src/main/java/*
	use source && java-pkg_dosrc commons-compiler-jdk/src/main/java/*
	use source && java-pkg_dosrc janino/src/main/java/*
}
