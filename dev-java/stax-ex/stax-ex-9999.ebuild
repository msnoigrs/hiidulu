# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="source"

EGIT_REPO_URI="https://github.com/kohsuke/stax-ex.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="Extensions to complement JSR-173 StAX API"
HOMEPAGE="https://github.com/kohsuke/stax-ex"
SRC_URI=""

LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE=""

COMMON_DEPEND="java-virtuals/stax-api"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEPEND}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEPEND}"

java_prepare() {
	find -name '*.jar' -print -delete

	find -name '*Test.java' -print -delete

	# build.xml is from maven-1 and tries to download jars to /root/.maven/
	rm -f build.xml || die
	cp "${FILESDIR}/build.xml" build.xml || die

	mkdir -p "${S}/lib" || die
	java-pkg_jar-from --into ${S}/lib --virtual stax-api
}

src_install() {
	java-pkg_dojar "stax-ex.jar"
	use source && java-pkg_dosrc src/java/*
}
