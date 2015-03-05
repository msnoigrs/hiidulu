# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A YAML 1.1 parser and emitter for Java 5"
HOMEPAGE="http://code.google.com/p/snakeyaml/"
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="src/main/java"

java_prepare() {
	rm -v pom.xml || die
}

src_install() {
	java-pkg-simple_src_install
}
