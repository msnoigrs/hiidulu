# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="the HTML5 parsing algorithm in Java"
HOMEPAGE="http://jchardet.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	rm -v dist/lib/chardet.jar

	if use source; then
		local srcdir="source/org/mozilla/intl/chardet"
		mkdir -p ${srcdir}
		cp -a src/*.java ${srcdir}
	fi
}

EANT_BUILD_TARGET="dist"

src_install() {
	java-pkg_dojar dist/lib/*.jar

	use source && java-pkg_dosrc source/org
}
