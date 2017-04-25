# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

MY_PN=pdfbox

DESCRIPTION="An open source Java library for parsing font files"
HOMEPAGE="http://pdfbox.apache.org/"
SRC_URI="mirror://apache/${MY_PN}/${PV}/${MY_PN}-${PV}-src.zip"

LICENSE="BSD"
SLOT="1.8"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x64-macos"
IUSE=""

COMMON_DEP="dev-java/jcl-over-slf4j:0"
RDEPEND="
	>=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND="
	>=virtual/jdk-1.6
	${COMMON_DEP}"

S="${WORKDIR}/${MY_PN}-${PV}/${PN}"

java_prepare() {
	mkdir lib || die
	java-pkg_jar-from --into lib jcl-over-slf4j

	cp "${FILESDIR}/gentoo-build.xml" build.xml
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/org
}
