# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/ymnk/jsch-agent-proxy.git"
MY_PN="jsch-agent-proxy"
EGIT_SOURCEDIR="${WORKDIR}/${MY_PN}"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="a proxy to ssh-agent and Pageant in Java."
HOMEPAGE="https://github.com/ymnk/jsch-agent-proxy"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jre-1.6"

S="${EGIT_SOURCEDIR}/${PN}"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

JAVA_ANT_ENCODING="utf-8"
EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
