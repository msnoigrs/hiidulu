# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="https://github.com/fusesource/hawtjni.git"

inherit git-r3 java-pkg-2 java-ant-2

DESCRIPTION="A JNI code generator based on the JNI generator used by the eclipse SWT project"
HOMEPAGE="http://jansi.fusesource.org/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" ${PN}/build.xml
}

#EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_compile() {
	cd ${PN} || die
	EANT_EXTRA_ARGS="-Dproject.name=${PN}" \
	java-pkg-2_src_compile
}

src_install() {
	java-pkg_dojar ${PN}/target/${PN}.jar

	use doc && java-pkg_dojavadoc ${PN}/target/site/apidocs
	use source && java-pkg_dosrc ${PN}/src/main/java/*
}
