# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/ymnk/jsch-agent-proxy.git"
MY_PN="jsch-agent-proxy"
EGIT_CHECKOUT_DIR="${WORKDIR}/${MY_PN}"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="a proxy to ssh-agent and Pageant in Java."
HOMEPAGE="https://github.com/ymnk/jsch-agent-proxy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/jsch-agent-proxy-core
	dev-java/jna:4"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"

S="${EGIT_CHECKOUT_DIR}/${PN}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir -p lib || die
	java-pkg_jar-from --into lib jsch-agent-proxy-core
	java-pkg_jar-from --into lib jna-4
}

JAVA_ANT_ENCODING="utf-8"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
