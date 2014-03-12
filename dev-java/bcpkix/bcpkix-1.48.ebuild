# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P="${PN}-jdk15on-${PV/./}"

DESCRIPTION="Java cryptography APIs"
HOMEPAGE="http://www.bouncycastle.org/java.html"
SRC_URI="http://www.bouncycastle.org/download/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="1.48"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x64-macos"

# Tests are currently broken. Needs further investigation.
# java.lang.RuntimeException: java.security.NoSuchProviderException: JCE cannot authenticate the provider BC
RESTRICT="test"

COMMON_DEPEND="
	dev-java/bcprov:${SLOT}"

DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${COMMON_DEPEND}"

RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	cd "${S}"
	mkdir -p src/main/java
	unzip -qq ./src.zip -d src/main/java
}

java_prepare() {
	# so that we don't need junit
	echo "Removing testcases' sources:"
	find . -path '*test/*.java' -print -delete \
		|| die "Failed to delete testcases."
	find . -name '*Test*.java' -print -delete \
		|| die "Failed to delete testcases."

	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib
	cd lib
	java-pkg_jar-from bcprov-${SLOT}
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
