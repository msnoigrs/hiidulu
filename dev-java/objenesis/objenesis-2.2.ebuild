# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A small Java library with one purpose: To instantiate a new object of a class"
HOMEPAGE="https://github.com/easymock/objenesis"
SRC_URI="https://github.com/easymock/objenesis/archive/2.2.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ppc ppc64"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

java_prepare() {
  cd main
  cp "${FILESDIR}"/gentoo-build.xml build.xml || die
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_compile() {
  cd main
  java-pkg-2_src_compile
}

src_install() {
	cd main
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
