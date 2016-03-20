# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_P="${P}-dist"

DESCRIPTION="A small set of classes to aid conversion between Objects and Strings."
HOMEPAGE="http://joda-convert.sourceforge.net/"
SRC_URI="https://github.com/JodaOrg/joda-convert/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

CDEPEND="dev-java/guava:18"
DEPEND="${CDEPEND}
	>=virtual/jdk-1.6"
RDEPEND="${CDEPEND}
	>=virtual/jre-1.6"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib || die
	java-pkg_jar-from --into lib guava-18 guava.jar
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_newjar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/main/java/org
}
