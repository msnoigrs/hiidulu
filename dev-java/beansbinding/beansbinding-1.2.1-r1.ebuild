# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementation of JSR295."
HOMEPAGE="http://java.net/projects/beansbinding/"
SRC_URI="https://beansbinding.dev.java.net/files/documents/6779/73673/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}"

java_prepare() {
	epatch ${FILESDIR}/svn.patch

	# Avoid the usual "Javadoc returned 1" error.
	java-ant_xml-rewrite \
		-f nbproject/build-impl.xml \
		-c -e javadoc \
		-a failonerror \
		-v "false"
}

src_install() {
	java-pkg_dojar "dist/${PN}.jar"
	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/*
}
