# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source examples"

inherit java-pkg-2 java-ant-2

DESCRIPTION="JFlex is a lexical analyzer generator for Java"
SRC_URI="http://${PN}.de/${P}.tar.gz"
HOMEPAGE="http://www.jflex.de/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

CDEPEND="dev-java/javacup:20060608"
RDEPEND=">=virtual/jre-1.6
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.6
	~dev-java/jflex-1.6.0:1.6.0
	${CDEPEND}"

IUSE="vim-syntax"

java_prepare() {
	sed -i s,"\(</project>\)",\
"\n  <target depends=\"compile\" name=\"javadoc\">\n    <javadoc \
packagenames=\"jflex\" sourcepath=\"src/main/java:build/generated-\
sources\" destdir=\"javadoc\" version=\"true\" />\n  </target>\n\1",g \
		build.xml
}

JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_GENTOO_CLASSPATH="ant-core"
WANT_ANT_TASKS="dev-java/javacup:20060608 dev-java/jflex:1.6.0"

src_compile() {
	java-pkg-2_src_compile

	# Compile another time, using our generated jar; for sanity.
	cp build/${P}.jar ${EANT_GENTOO_CLASSPATH_EXTRA}
	java-pkg-2_src_compile
}

# EANT_TEST_GENTOO_CLASSPATH doesn't support EANT_GENTOO_CLASSPATH_EXTRA yet.
RESTRICT="test"

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar build/${P}.jar ${PN}.jar
	java-pkg_dolauncher "${PN}" --main jflex.Main
	java-pkg_register-ant-task

	if use doc ; then
		dodoc doc/manual.pdf changelog.md
		dohtml -r doc/*
		java-pkg_dojavadoc javadoc
	fi

	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc src/main

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}/lib/${PN}.vim"
	fi
}
