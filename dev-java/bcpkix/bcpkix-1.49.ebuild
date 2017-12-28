# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_P="${PN}-jdk15on-${PV/./}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="http://www.bouncycastle.org/java.html"
SRC_URI="http://polydistortion.net/bc/download/${MY_P}.tar.gz"

KEYWORDS="amd64 ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos"

LICENSE="BSD"
SLOT="1.49"

CDEPEND="dev-java/bcprov:${SLOT}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.6
	${CDEPEND}"

S="${WORKDIR}/${MY_P}"

JAVA_GENTOO_CLASSPATH="
	bcprov-${SLOT}
"

RESTRICT="test"

src_unpack() {
	default
	cd "${S}"
	unpack ./src.zip
}

 java_prepare() {
	JAVA_RM_FILES=(
		org/bouncycastle/cms/test/*
		org/bouncycastle/pkcs/test/*
		org/bouncycastle/tsp/test/*
		org/bouncycastle/cert/cmp/test/*
		org/bouncycastle/cert/crmf/test/*
		org/bouncycastle/cert/ocsp/test/*
		org/bouncycastle/cert/test/*
		org/bouncycastle/openssl/test/*
		org/bouncycastle/mozilla/test/*
		org/bouncycastle/eac/test/*
		org/bouncycastle/dvcs/test/*
	)
 }

src_compile() {
	java-pkg-simple_src_compile
}

src_install() {
	java-pkg-simple_src_install
	use source && java-pkg_dosrc org
}
