# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-nodeps"

EGIT_REPO_URI="git://github.com/wmeissner/jnr-x86asm.git"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="A pure-java port of asmjit."
HOMEPAGE="http://github.com/wmeissner/jnr-x86asm/"
#SRC_URI="http://github.com/wmeissner/${PN}/tarball/0.1 -> ${P}.tar.gz"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

#src_unpack() {
#	unpack ${A}
#	cd "${WORKDIR}" || die
#	mv w* "${P}" || die
#}

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
