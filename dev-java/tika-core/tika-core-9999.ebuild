# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc source"

EGIT_MASTER="trunk"
EGIT_REPO_URI="git://github.com/apache/tika.git"
EGIT_PROJECT="tika"

inherit git-2 java-pkg-2 java-ant-2

DESCRIPTION="a content analysis toolkit"
HOMEPAGE="http://tika.apache.org/"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5"

java_prepare() {
	cd ${PN}
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	rm -v src/main/java/org/apache/tika/config/TikaActivator.java || die
	find src -name package-info.java -exec sed -i -e '/aQute.bnd.annotation.Version/ d' {} +
}

src_compile() {
	cd ${PN}
	EANT_EXTRA_ARGS="-Dproject.name=${PN}" \
	java-pkg-2_src_compile
}

src_install() {
	cd ${PN}
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
