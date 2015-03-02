# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

MY_P="slf4j-${PV}"
DESCRIPTION="The Simple Logging Facade for Java"
HOMEPAGE="http://www.slf4j.org/"
SRC_URI="http://www.slf4j.org/dist/${MY_P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${MY_P}/${PN}"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
