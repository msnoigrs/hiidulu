# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

EGIT_REPO_URI="git://github.com/wmeissner/jnr-x86asm.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="A pure-java port of asmjit."
HOMEPAGE="http://github.com/wmeissner/jnr-x86asm/"
#SRC_URI="http://github.com/wmeissner/${PN}/tarball/0.1 -> ${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=jnr-x86asm"

src_install() {
	java-pkg_dojar target/jnr-x86asm.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
