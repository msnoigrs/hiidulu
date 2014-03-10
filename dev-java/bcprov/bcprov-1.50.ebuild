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
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos"

# Tests are currently broken. Needs further investigation.
# java.security.NoSuchAlgorithmException: Cannot find any provider supporting McElieceFujisakiWithSHA256
RESTRICT="test"

# The src_unpack find needs a new find
# https://bugs.gentoo.org/show_bug.cgi?id=182276
DEPEND=">=virtual/jdk-1.6
	userland_GNU? ( >=sys-apps/findutils-4.3 )
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.6"

IUSE="userland_GNU"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	cd "${S}" || die

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
}

JAVA_ANT_ENCODING="iso-8859-1"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
