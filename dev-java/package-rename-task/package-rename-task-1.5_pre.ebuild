# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Ant task to relocate code from one package tree to another"
HOMEPAGE="https://package-rename-task.dev.java.net/"
MY_TARBALL="${P}.tar.gz"
SRC_URI="https://osdn.net/frs/chamber_redir.php?m=iij&f=%2Fusers%2F13%2F13649%2F${MY_TARBALL} -> ${MY_TARBALL}"

LICENSE="CDDL"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	dev-java/ant-core"

java_prepare() {
	cp "${FILESDIR}/gentoo-build.xml" build.xml
	# remove maven things at the moment.
	rm -v src/main/java/com/sun/wts/tools/ant/PackageRenameMojo.java

	mkdir lib
	java-pkg_jar-from --into lib --build-only ant-core ant.jar
}

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task
	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*
}
