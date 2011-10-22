# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Some java libary"
HOMEPAGE="http://kxml.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${PN}2-src-${PV}.zip"
LICENSE="BSD"
SLOT="2"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S=${WORKDIR}

java_prepare() {
	rm -v dist/*
	find bin -name "*.class" | xargs rm -v
	#We do not remove the lib/xmlpull_*.jar, the source is avail at
	# http://www.xmlpull.org/v1/download/ but ONLY the latest version
}

EANT_BUILD_TARGET="build_jar"

src_install() {
	java-pkg_newjar dist/${PN}2-${PV}.jar ${PN}2.jar
	use source && java-pkg_dosrc src/org
	use doc && java-pkg_dojavadoc www/kxml2/javadoc
	use examples && java-pkg_doexamples samples
}
