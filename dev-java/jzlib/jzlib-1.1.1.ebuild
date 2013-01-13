# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JZlib is a re-implementation of zlib in pure Java."
HOMEPAGE="http://www.jcraft.com/jzlib/"
SRC_URI="http://www.jcraft.com/${PN}/${P}.zip"

LICENSE="jcraft"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

java_prepare() {
	cp "${FILESDIR}/jzlib-1.1.1_build.xml" "${S}/build.xml" || die
}

EANT_BUILD_TARGET="dist"

src_install() {
	java-pkg_newjar dist/lib/jzlib*.jar jzlib.jar
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src
	dodoc README ChangeLog || die
}
