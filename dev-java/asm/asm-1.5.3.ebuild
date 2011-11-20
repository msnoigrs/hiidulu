# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WANT_ANT_TASKS="ant-owanttask"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Bytecode manipulation framework for Java"
HOMEPAGE="http://asm.ow2.org"
SRC_URI="http://download.forge.objectweb.org/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="1.5"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

DEPEND=">=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

RESTRICT="test"

java_prepare() {
	echo "objectweb.ant.tasks.path /usr/share/ant-owanttask/lib/ow_util_ant_tasks.jar" \
		>> build.properties
}

EANT_DOC_TARGET=jdoc

src_install() {
	for x in output/dist/lib/*.jar ; do
		java-pkg_newjar ${x} $(basename ${x/-${PV}})
	done
	use doc && java-pkg_dohtml -r output/dist/doc/javadoc/user/*
	use source && java-pkg_dosrc src/*
}
