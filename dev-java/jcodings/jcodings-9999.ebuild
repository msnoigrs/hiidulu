# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="source"

EGIT_REPO_URI="https://github.com/jruby/jcodings.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="Byte-based encoding support library for Java"
HOMEPAGE="http://jruby.codehaus.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

EANT_BUILD_TARGET="build"

src_install() {
	java-pkg_newjar target/${PN}.jar
	use source && java-pkg_dosrc src/*
}
