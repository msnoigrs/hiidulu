# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="JFlex is a lexical analyzer generator for Java"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.jflex.de/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

CDEPEND=">=dev-java/javacup-0.11a_beta20060608"
RDEPEND=">=virtual/jre-1.6
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core
	${CDEPEND}"
#	dev-java/junit

IUSE="vim-syntax"

JAVA_PKG_BSFIX_NAME="src/build.xml"

java_prepare() {
	rm -rfv ${S}/src/java_cup
	mkdir "${S}/tools"
	mv "${S}/lib/JFlex.jar" "${S}/tools/"
	cd "${S}/tools"
	java-pkg_jar-from javacup javacup.jar java_cup.jar

	# remove dependency of junit
	rm -rf ${S}/src/JFlex/tests

	java-ant_rewrite-classpath ${S}/src/build.xml
}

src_compile() {
	ANT_TASKS="javacup"
#	jflex_cp="$(java-pkg_getjars --build-only junit):$(java-pkg_getjars ant-core,javacup)"
	jflex_cp="$(java-pkg_getjar --build-only ant-core ant.jar)"
	jflex_cp="${jflex_cp}:$(java-pkg_getjar javacup javacup-runtime.jar)"
#	echo "echo echo echo ${jflex_cp}"
	cd "${S}/src"
	eant -Dgentoo.classpath="${jflex_cp}" cbuild

	rm "${S}/tools/JFlex.jar"
	mv "${S}/lib/JFlex.jar" "${S}/tools/"

	einfo "Recompiling using the newly generated JFlex library"
	eant -Dgentoo.classpath="${jflex_cp}" cbuild
}

src_install() {
	java-pkg_dojar lib/JFlex.jar
	java-pkg_dolauncher "${PN}" --main JFlex.Main
	java-pkg_register-ant-task

#	dodoc doc/manual.pdf doc/manual.ps.gz src/changelog
	dodoc doc/manual.pdf doc/manual.ps.gz
	dohtml -r doc/*

	use source && java-pkg_dosrc src/JFlex

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins "${S}/lib/jflex.vim"
	fi
}
