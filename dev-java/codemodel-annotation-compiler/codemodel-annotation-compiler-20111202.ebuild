# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-ant-2

DESCRIPTION="CodeModel Annotation Compiler"
HOMEPAGE="https://codemodel.java.net/"
MY_TARBALL="${P}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13652%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="|| ( CDDL GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="dev-java/codemodel:2
	dev-java/istack-commons"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}
	dev-java/ant-core"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml

	mkdir lib && cd lib
	java-pkg_jar-from codemodel-2
	java-pkg_jar-from istack-commons istack-commons-tools.jar
	java-pkg_jar-from --build-only ant-core ant.jar
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
