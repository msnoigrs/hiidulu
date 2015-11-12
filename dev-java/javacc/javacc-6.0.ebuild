# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

JAVA_PKG_IUSE="doc examples source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Java Compiler Compiler - The Java Parser Generator"
HOMEPAGE="https://javacc.java.net/"
# svn export https://svn.java.net/svn/javacc~svn/branches/version_60 javacc
MY_TARBALL="javacc-6.0.tar.gz"
SRC_URI="http://osdn.jp/frs/chamber_redir.php?m=iij&f=%2Fusers%2F9%2F9542%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

RESTRICT="test"

S="${WORKDIR}/${PN}"

JAVA_ANT_ENCODING="utf-8"

java_prepare() {
	epatch "${FILESDIR}"/${PN}-4.0-javadoc.patch
	rm -v lib/junit*/*.jar || die

	# so that we don't need junit
	echo "Removing testcases' sources:"
	rm -v src/org/javacc/jjtree/JJTreeOptionsTest.java || die
	rm -v src/org/javacc/parser/OptionsTest.java || die
	rm -v src/org/javacc/parser/ExpansionTest.java || die
	rm -rv src/org/javacc/parser/test || die
	rm -v src/org/javacc/JavaCCTestCase.java || die
	rm -rv src/org/javacc/jjdoc/test || die
}

#JAVA_ANT_REWRITE_CLASSPATH="yes"
#JAVA_ANT_CLASSPATH_TAGS+=" javadoc"
#EANT_GENTOO_CLASSPATH="junit"

src_compile() {
	eant generated-files
	eant jar
	cp bin/lib/${PN}.jar bootstrap
	eant realclean

	eant -Dbootstrap.javacc.mainclass="org.javacc.parser.Main" -Dbootstrap.jjtree.mainclass="org.javacc.jjtree.Main" jar $(use_doc)
}

src_install() {
	java-pkg_dojar bin/lib/${PN}.jar

	dodoc README

	if use doc; then
		java-pkg_dohtml -r www/*
		java-pkg_dojavadoc doc/api
	fi
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc src/*

	echo "JAVACC_HOME=${EPREFIX}/usr/share/javacc/" > "${T}"/22javacc
	doenvd "${T}"/22javacc

	echo "export VERSION=${PV}" > "${T}"/pre

	local launcher
	for launcher in javacc jjdoc jjtree
	do
		java-pkg_dolauncher ${launcher} -pre "${T}"/pre --main ${launcher}
	done
}
