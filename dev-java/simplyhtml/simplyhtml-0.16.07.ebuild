# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2 versionator

MY_PN="SimplyHTML"
MY_PV="$(replace_all_version_separators _)"

DESCRIPTION="Text processing application based on HTML and CSS files."
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/stable/${MY_PN}_src_${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris"
IUSE=""

COMMON_DEP="dev-java/javahelp
	dev-java/gnu-regexp:1"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${PN}-${MY_PV}/src"

java_prepare() {
	# it wants to copy lib jars
	sed -i '/copy file/d' build.xml || die
}

EANT_EXTRA_ARGS="-Dclasspath=\"$(java-pkg_getjars javahelp,gnu-regexp-1)\""

src_install() {
	cd ..
	java-pkg_dojar dist/lib/${MY_PN}*.jar

	dodoc readme.txt || die

	use doc && java-pkg_dojavadoc dist/api
	use source && java-pkg_dosrc src/com src/de
}
