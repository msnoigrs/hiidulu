# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_PN="jsr-305"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="JSR 305: Annotations for Software Defect Detection in Java"
SRC_URI="http://dev.gentoo.gr.jp/~igarashi/distfiles/${MY_P}.tar.gz"
HOMEPAGE="http://code.google.com/p/jsr-305/"
LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
SLOT="0"

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${MY_P}"

JAVA_PKG_BSFIX_ALL="yes"

src_compile() {
	cd ri
	EANT_BUILD_TARGET="jars" \
	EANT_DOC_TARGET="" java-pkg-2_src_compile
}

src_install() {
	cd ri
	java-pkg_dojar build/${PN}.jar

	if use examples; then
		dodir /usr/share/doc/${PF}/examples/
		cp -r "${S}"/sampleUses/* "${D}"/usr/share/doc/${PF}/examples/ || die "Could not install examples"
	fi

	if use source; then
		cd "${S}"/ri/src/main/java
		java-pkg_dosrc javax
	fi

	if use doc; then
		cd ${S}
		java-pkg_dojavadoc javadoc
	fi
}
