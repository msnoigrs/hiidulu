# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Embedded run-time Java compiler."
HOMEPAGE="http://janino.net/
http://docs.codehaus.org/display/JANINO/Home"
SRC_URI="http://dist.codehaus.org/janino/${P}.zip"

SLOT="2.6"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	app-arch/unzip"

src_unpack() {
	unpack "${A}"
	cd "${S}"
#	mkdir -p commons-compiler-jdk/src/main/java
	mkdir -p commons-compiler/src/main/java
	mkdir -p janino/src/main/java
#	unzip -qq commons-compiler-jdk-src.zip -d commons-compiler-jdk/src/main/java || die unzip failed
	unzip -qq commons-compiler-src.zip -d commons-compiler/src/main/java || die unzip failed
	unzip -qq janino-src.zip -d janino/src/main/java || die unzip failed
}

java_prepare() {
	rm -v *.jar *.zip

	mkdir janino/lib
	cd janino/lib
	java-pkg_jar-from --build-only ant-core ant.jar

#	cp "${FILESDIR}/gentoo-build.xml" commons-compiler-jdk/build.xml
	cp "${FILESDIR}/gentoo-build.xml" "${S}/commons-compiler/build.xml"
	cp "${FILESDIR}/gentoo-build.xml" "${S}/janino/build.xml"
}

src_compile() {
	mkdir dist
#	cd "${S}/commons-compiler-jdk"
#	eant -Dproject.name=commons-compiler-jdk  $(use_doc)
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
}
