# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

JAVA_PKG_IUSE="source"
inherit java-pkg-2 java-ant-2

DESCRIPTION="Platform constants for Java"
HOMEPAGE="http://kenai.com/projects/constantine"
SRC_URI="http://kenai.com/downloads/constantine/constantine-src-0.4.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use source && java-pkg_dosrc src/*
}
