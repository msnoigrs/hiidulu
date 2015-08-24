# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="A java extension of BSD YACC-compatible parser generator"
HOMEPAGE="http://byaccj.sourceforge.net/"
MY_P="${PN}${PV}_src"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=virtual/jre-1.6
	sys-apps/sed"
RDEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${PN}${PV}"

src_prepare() {
	sed -i -e 's/mktemp/mkstemp/g' ${S}/src/main.c || die
	sed -i -e 's/-o yacc -arch i386 -isysroot \/Developer\/SDKs\/MacOSX10.4u.sdk -mmacosx-version-min=10.4/-o yacc \$(CFLAGS)/' ${S}/src/Makefile || die
}

src_compile() {
	emake -C src CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS}" linux || die "failed to build"
}

src_install() {
	newbin src/yacc.linux ${PN}  || die "missing bin"
}
