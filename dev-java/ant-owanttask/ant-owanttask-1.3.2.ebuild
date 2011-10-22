# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2

MY_PN="ow_util_ant_tasks"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="ObjectWeb's Ant tasks"
SRC_URI="http://download.forge.objectweb.org/monolog/${MY_P}.zip"
HOMEPAGE="http://monolog.objectweb.org/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	${RDEPEND}
	>=dev-java/ant-core-1.7.0"

S="${WORKDIR}"

#src_prepare() {
#	epatch ${FILESDIR}/MultipleCopy-compat-ant17.patch
#}

src_compile() {
	local antflags="jar"
	use doc && antflags="${angflags} jdoc"
	eant ${antflags}
}

src_install() {
	java-pkg_dojar output/lib/${MY_PN}.jar
	java-pkg_dohtml doc/*
	use doc && java-pkg_dohtml -r output/jdoc
	use source && java-pkg_dosrc src/org
}
