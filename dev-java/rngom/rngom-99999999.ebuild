# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

JAVA_PKG_IUSE="doc source"

ESVN_REPO_URI="https://svn.java.net/svn/rngom~svn/trunk/rngom"

WANT_ANT_TASKS="ant-nodeps"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="RNGOM is an open-source Java library for parsing RELAX NG grammars."
HOMEPAGE="https://rngom.java.net/"
#SRC_URI="https://rngom.dev.java.net/files/documents/1647/26424/${P}.zip"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

COMMON_DEP="dev-java/relaxng-datatype"

DEPEND=">=virtual/jdk-1.5
	dev-java/javacc
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"

java_prepare() {
#	epatch ${FILESDIR}/without-retroweaver.patch

	cp "${FILESDIR}/gentoo-build.xml" build.xml || die

	cd lib
	java-pkg_jar-from relaxng-datatype
#	java-pkg_jar-from xsdlib
#	java-pkg_jar-from --build-only package-rename-task
#	cd "${S}/lib/javacc/bin/lib"
#	java-pkg_jar-from --build-only javacc
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/doc/api
	use source && java-pkg_dosrc src/*
}
