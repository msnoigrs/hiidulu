# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P="dtd-parser-${PV}"
DESCRIPTION="Sun DTDParser"
HOMEPAGE="http://java.net/projects/dtd-parser"
#SRC_URI="mirror://gentoo/dtd-parser-${PV}-src.zip"
MY_TARBALL="${MY_P}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13647%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"

IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

S="${WORKDIR}/${MY_P}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml || die
}

EANT_EXTRA_ARGS="-Dproject.name=dtd-parser"

src_install() {
	java-pkg_dojar target/dtd-parser.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/*
}
