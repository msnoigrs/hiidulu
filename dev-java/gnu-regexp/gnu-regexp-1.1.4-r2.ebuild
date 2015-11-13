# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit java-pkg-2 java-ant-2

MY_P="gnu.regexp-${PV}"

DESCRIPTION="GNU regular expression package for Java"
SRC_URI="ftp://ftp.tralfamadore.com/pub/java/${MY_P}.tar.gz"
HOMEPAGE="http://savannah.gnu.org/projects/gnu-regexp"
LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 amd64"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	epatch "${FILESDIR}/regexp-1.1.5dev.patch"
	rm -rf doc/api/*
	cp ${FILESDIR}/${PN}-build.xml build.xml
}

src_install() {
	java-pkg_dojar ${PN}.jar
	dodoc README
	use doc && java-pkg_dohtml -r docs/*
	use source && java-pkg_dosrc src/gnu
}
