# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="doc examples source"

ESVN_REPO_URI="https://svn.java.net/svn/javahelp~svn/trunk"

#inherit subversion versionator java-pkg-2 java-ant-2
inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="The JavaHelp system online help system"
HOMEPAGE="http://javahelp.java.net/"
#MY_PN="${PN}2"
#MY_PV="${PV/_p/_svn}"
#SRC_URI="https://${PN}.dev.java.net/files/documents/5985/145533/${MY_PN}-src-${MY_PV}.zip"
#SRC_URI="http://download.java.net/javadesktop/javahelp/javahelp2_0_05.zip"
SRC_URI=""
LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

COMMON_DEP="java-virtuals/servlet-api:3.0
	>=dev-java/jdic-0.9.5"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

#S="${WORKDIR}/${MY_PN}-${MY_PV}/"
BDIR="${S}/javahelp_nbproject"

JAVA_PKG_BSFIX_NAME="build.xml build-impl.xml"

#src_unpack() {
#	unpack "${A}"
	# jdic does not currently build out of the box against the browsers we have
#	cd "${S}/jhMaster/JavaHelp/src/new/" || die
#	rm -v javax/help/plaf/basic/BasicNativeContentViewerUI.java || die
#}

java_prepare() {
	mkdir -p "${BDIR}/lib" || die
	cd "${BDIR}/lib" || die
	java-pkg_jar-from --virtual servlet-api-3.0
	java-pkg_jar-from jdic jdic.jar
#	java-pkg_filter-compiler jikes
}

#_eant() {
#	cd ${BDIR} || die
#	eant \
#		-Djdic-jar-present=true \
#		-Djdic-zip-present=true \
#		-Dtomcat-zip-present=true \
#		-Dservlet-jar-present=true \
#		${@}
#		-Dservlet-jar="$(java-pkg_getjar --virtual servlet-api-2.5 servlet-api.jar)" \
#		-Djsp-jar="$(java-pkg_getjar --virtual servlet-api-2.5 jsp-api.jar)" \
#}

EANT_BUILD_TARGET="release"
EANT_EXTRA_ARGS="-Dservlet-jar-present=true -Djdic-zip-present=true \
	-Djdic-jar-present=true -Dtomcat-zip-present=true"
src_compile() {
#	_eant release $(use_doc)
	cd ${BDIR} || die
	java-pkg-2_src_compile
}

#Does not actually run anything
#src_test() {
#	_eant test
#}

src_install() {
	cd jhMaster/JavaHelp || die
#	dodoc README || die
#	dohtml *.{html,css} || die
	java-pkg_dojar "${BDIR}"/dist/lib/*.jar
	java-pkg_dolauncher jhsearch \
		--main com.sun.java.help.search.QueryEngine
	java-pkg_dolauncher jhindexer \
		--main com.sun.java.help.search.Indexer
	use doc && java-pkg_dojavadoc "${BDIR}/dist/lib/javadoc"
	cd "${S}"
	use source && java-pkg_dosrc \
		./jhMaster/JSearch/*/com \
		./jhMaster/JavaHelp/src/*/{javax,com}
	use examples && java-pkg_doexamples jhMaster/JavaHelp/demos
}

#pkg_postinst() {
#	elog "Native browser integration is disabled because it needs jdic"
#	elog "which does not build out of the box. See"
#	elog "https://bugs.gentoo.org/show_bug.cgi?id=53897 for progress"
#}
