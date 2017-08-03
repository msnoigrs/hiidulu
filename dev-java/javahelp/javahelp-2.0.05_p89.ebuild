# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
WANT_ANT_TASKS="ant-nodeps"
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="The JavaHelp system online help system"
HOMEPAGE="http://javahelp.java.net/"
MY_PN="${PN}2"
MY_PV="${PV/_p/_svn}"
MY_P="${MY_PN}-${MY_PV}"
MY_TARBALL="${MY_P}.tar.gz"
#SRC_URI="https://${PN}.dev.java.net/files/documents/5985/145533/${MY_PN}-src-${MY_PV}.zip"
#SRC_URI="http://download.java.net/javadesktop/javahelp/javahelp2_0_05.zip"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13639%2F${MY_TARBALL} -> ${MY_TARBALL}"
LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

COMMON_DEP="java-virtuals/servlet-api:3.0"
#	>=dev-java/jdic-0.9.5"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}/"
BDIR="${S}/javahelp_nbproject"

JAVA_PKG_BSFIX_NAME="build.xml build-impl.xml"

java_prepare() {
	# jdic does not currently build out of the box against the browsers we have
	cd "${S}/jhMaster/JavaHelp/src/new/" || die
	rm -v javax/help/plaf/basic/BasicNativeContentViewerUI.java || die

	mkdir -p "${BDIR}/lib" || die
	cd "${BDIR}/lib" || die
	java-pkg_jar-from --virtual servlet-api-3.0
	#java-pkg_jar-from jdic jdic.jar
}

EANT_BUILD_TARGET="release"
#EANT_EXTRA_ARGS="-Dservlet-jar-present=true -Djdic-zip-present=true \
#	-Djdic-jar-present=true -Dtomcat-zip-present=true"
EANT_EXTRA_ARGS="-Dservlet-jar-present=true -Djdic-zip-present=false \
	-Djdic-jar-present=false -Dtomcat-zip-present=true"
src_compile() {
	cd ${BDIR} || die
	java-pkg-2_src_compile
}

src_install() {
	cd jhMaster/JavaHelp || die
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
