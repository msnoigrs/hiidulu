# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2 versionator

DESCRIPTION="Text processing application based on HTML and CSS files."
HOMEPAGE="http://${PN}.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/stable/${PN}_src-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris"
IUSE=""

COMMON_DEP="dev-java/javahelp
	dev-java/gnu-regexp:1
	dev-java/mnemonicsetter"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

java_prepare() {
	sed -i -e 's#\(name="classpath" value="\${jhall.jar}\)#\1:../lib/mnemonicsetter.jar#' src/build.xml || die
	mkdir lib
	java-pkg_jar-from --into lib mnemonicsetter
	java-pkg_jar-from --into lib javahelp jhall.jar
	java-pkg_jar-from --into lib gnu-regexp-1 gnu-regexp.jar gnu-regexp-1.1.4.jar
}

EANT_BUILD_TARGET="jar"
EANT_BUILD_XML="src/build.xml"

src_install() {
	java-pkg_dojar dist/lib/SimplyHTML*.jar

	dodoc readme.txt || die

	use doc && java-pkg_dojavadoc dist/api
	use source && java-pkg_dosrc src/com src/de
}
