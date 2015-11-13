# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2 versionator

MY_PV=$(replace_all_version_separators '_')

DESCRIPTION="JiBX: Binding XML to Java Code"
HOMEPAGE="http://jibx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${MY_PV}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEP="dev-java/bcel:0
	java-virtuals/stax-api
	dev-java/xpp3:0
	dev-java/qdox:1.12
	dev-java/log4j-over-slf4j"

DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core:0
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	dev-java/slf4j-api
	dev-java/logback-core
	dev-java/logback-classic
	${COMMON_DEP}"

S="${WORKDIR}/${PN}"

java_prepare() {
	sed -i -e '/s_logger.setLevel(level);/ d' build/src/org/jibx/schema/TreeWalker.java

	cd lib || die
	rm -v *.jar || die
	java-pkg_jar-from --build-only ant-core
	java-pkg_jar-from bcel
	java-pkg_jar-from --virtual stax-api
	java-pkg_jar-from xpp3
	java-pkg_jar-from qdox-1.12
	java-pkg_jar-from log4j-over-slf4j
}

EANT_BUILD_XML="build/build.xml"
EANT_BUILD_TARGET="small-jars"

src_install() {
	java-pkg_dojar "${S}"/lib/${PN}*.jar

	dodoc changes.txt docs/binding.dtd docs/binding.xsd || die
	dohtml readme.html || die

	use doc && {
		java-pkg_dohtml -r docs/*
		cp -R starter "${D}/usr/share/doc/${PF}"
		cp -R tutorial "${D}/usr/share/doc/${PF}"
	}

	java-pkg_register-ant-task

	use source && java-pkg_dosrc build/src/* build/extras/*
}
