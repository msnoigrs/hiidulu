# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/cbeust/jcommander.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="parse command line parameters"
HOMEPAGE="http://jcommander.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	rm -v src/main/java/module-info.java
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
