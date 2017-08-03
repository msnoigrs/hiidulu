# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Fast Infoset"
HOMEPAGE="http://fi.java.net/"
#SRC_URI="https://fi.dev.java.net/files/documents/2634/136954/FastInfosetPackage_src_${PV}.zip"
SRC_URI=""
MY_TARBALL="${P}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13648%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

# for utilities
COMMON_DEP="java-virtuals/stax-api"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	find -name '*.jar' -print -delete

	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib

	java-pkg_jar-from --into lib --virtual stax-api
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
