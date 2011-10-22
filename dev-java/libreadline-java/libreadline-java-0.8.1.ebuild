# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 eutils

#ECVS_SERVER="java-readline.cvs.sourceforge.net:/cvsroot/java-readline"
#ECVS_MODULE="java-readline"
#ECVS_CO_OPTS="-D 2004-01-08"
#ECVS_UP_OPTS="-D 2004-01-08 -dP"

DESCRIPTION="A JNI-wrapper to GNU Readline."
HOMEPAGE="http://java-readline.sourceforge.net/"
SRC_URI="mirror://sourceforge/java-readline/${PN}-0.8.0-src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="elibc_FreeBSD"

COMMON_DEP="sys-libs/ncurses"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RESTRICT="test"

S="${WORKDIR}/${PN}-0.8.0"

src_prepare() {
	cd "${S}"
	epatch "${FILESDIR}/${PV}-cvs.patch"
	epatch "${FILESDIR}/termcap-to-ncurses.patch"
	# bug #157387, reported upstream
	epatch "${FILESDIR}/${PN}-0.8.0-gmake.patch"

	# bug #157390
	sed -i "s/^\(JC_FLAGS =\)/\1 $(java-pkg_javac-args)/" Makefile || die
	if use elibc_FreeBSD; then
		sed -i -e '/JAVANATINC/s:linux:freebsd:' Makefile || die "sed JAVANATINC failed"
	fi
}

src_compile() {
	emake -j1 || die "failed to compile"
	if use doc; then
		emake -j1 apidoc || die "failed to generate docs"
	fi
}

src_install() {
	java-pkg_doso *.so
	java-pkg_dojar *.jar
	use source && java-pkg_dosrc src/*
	use doc && java-pkg_dojavadoc api
	dodoc NEWS README README.1st TODO || die
}
