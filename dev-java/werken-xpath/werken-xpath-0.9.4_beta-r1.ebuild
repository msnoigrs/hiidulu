# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source"

inherit eutils versionator java-pkg-2 java-ant-2

MY_PN=${PN//-/.}
MY_PV=$(replace_version_separator 3 '-')
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="W3C XPath-Rec implementation for DOM4J"
HOMEPAGE="http://sourceforge.net/projects/werken-xpath/"
SRC_URI="mirror://gentoo/${MY_P}-src.tar.gz"
# This tarball was acquired from jpackage's src rpm of the package by the same
# name

LICENSE="werken.xpath"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

# need the versioned atom to get keep ensure dep happy
COMMON_DEP="
	dev-java/jdom:1.0
	>=dev-java/antlr-2.7.7:0[java]"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

S="${WORKDIR}/${MY_PN}"

JAVA_ANT_REWRITE_CLASSPATH="yes"

java_prepare() {
	# Courtesy of JPackages :)
#	epatch "${FILESDIR}/${P}-jpp-compile.patch"
#	epatch "${FILESDIR}/${P}-jpp-jdom.patch"
#	epatch "${FILESDIR}/${P}-jpp-tests.patch"
#	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}"/werken-xpath-Driver.patch
	epatch "${FILESDIR}"/werken-xpath-ElementNamespaceContext.patch
	epatch "${FILESDIR}"/werken-xpath-NodeTypeStep.patch
	epatch "${FILESDIR}"/werken-xpath-ParentStep.patch
	epatch "${FILESDIR}"/werken-xpath-Partition.patch
	epatch "${FILESDIR}"/werken-xpath-StringFunction.patch
	epatch "${FILESDIR}"/werken-xpath-Test.patch
	epatch "${FILESDIR}"/werken-xpath-UnAbbrStep.patch
	epatch "${FILESDIR}"/werken-xpath-runtests_sh.patch

	cd "${S}/lib"
	# In here we have ant starter scripts
	rm -fr bin
	rm -f *.jar

	# compile target needs these
#	java-pkg_jar-from jdom-1.0_beta9
#	java-pkg_jar-from antlr
}

EANT_BUILD_TARGET="package"
EANT_GENTOO_CLASSPATH="jdom-1.0 antlr"
EANT_EXTRA_ARGS="-Dbuild.javadocs=build/api"

#src_compile() {
#	local antflags="package"
#
#	# java.class.path is used by the prepare.grammars target that
#	# runs antlr
#	local jdomjars="$(java-pkg_getjars jdom-1.0_beta9)"
#	local antlrjars="$(java-pkg_getjars antlr)"
#	local antflags="${antflags} -Djava.class.path=${jdomjars}:${antlrjars}"
#
#	use doc && antflags="${antflags} javadoc -Dbuild.javadocs=build/api"
#
#	eant ${antflags} || die "compile failed"
#}

src_install() {
	java-pkg_dojar build/${MY_PN}.jar

	dodoc README TODO LIMITATIONS || die
	use doc && java-pkg_dojavadoc build/api
	use source && java-pkg_dosrc src/*
}
