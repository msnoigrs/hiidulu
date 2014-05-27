# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A fast, programmer-friendly, free CSV library for Java"
HOMEPAGE="http://supercsv.sourceforge.net/"
SRC_URI="mirror://sourceforge/supercsv/2.2.0/${PN}-distribution-${PV}-bin.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${PN}"

src_unpack() {
  unpack ${A}
  mkdir -p "${S}/src/main/java"
  cd "${S}/src/main/java"
  jar xf "${S}/${PN}-${PV}-sources.jar"
}

java_prepare() {
  cp ${FILESDIR}/gentoo-build.xml build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
