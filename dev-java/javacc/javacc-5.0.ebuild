# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="Java Compiler Compiler - The Java Parser Generator"
HOMEPAGE="https://javacc.dev.java.net/"
SRC_URI="http://java.net/projects/javacc/downloads/download/javacc-5.0src.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
DEPEND=">=virtual/jdk-1.5
	test? ( dev-java/ant-junit
			dev-java/junit:0 )"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${PN}"

JAVA_ANT_ENCODING="utf-8"

java_prepare() {
#	epatch ${FILESDIR}/javacc-cvs.patch

	epatch ${FILESDIR}/${PN}-4.0-javadoc.patch
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

src_compile() {
	eant generated-files
	eant jar
	cp bin/lib/${PN}.jar bootstrap
	eant realclean

	eant -Dbootstrap.javacc.mainclass="org.javacc.parser.Main" -Dbootstrap.jjtree.mainclass="org.javacc.jjtree.Main" jar $(use_doc)
}

src_test() {
	ANT_TASKS="ant-junit" eant \
		-Djunit.jar="$(java-pkg_getjar --build-only junit junit.jar)" test
}

src_install() {
	java-pkg_dojar bin/lib/${PN}.jar

	dodoc README || die

	if use doc; then
		java-pkg_dohtml -r www/*
		java-pkg_dojavadoc doc/api
	fi
	if use examples; then
		dodir /usr/share/doc/${PF}/examples
		cp -R examples/* ${D}/usr/share/doc/${PF}/examples
	fi
	use source && java-pkg_dosrc src/*

	echo "JAVACC_HOME=/usr/share/javacc/" > ${T}/22javacc
	doenvd ${T}/22javacc

	echo "export VERSION=5.0" > ${T}/pre

	local launcher
	for launcher in javacc jjdoc jjtree
	do
		java-pkg_dolauncher ${launcher} -pre ${T}/pre --main ${launcher}
	done
}
