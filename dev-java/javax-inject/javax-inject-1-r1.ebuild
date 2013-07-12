# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Dependency Injection for Java (JSR-330)"
HOMEPAGE="http://code.google.com/p/atinject/"
SRC_URI="http://atinject.googlecode.com/files/javax.inject.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

src_unpack() {
	unpack "${A}"
	mkdir -p "${P}"/src/main/java
	unzip -qq javax.inject-src.zip -d "${P}"/src/main/java
}

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_newjar target/${PN}.jar javax.inject.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
