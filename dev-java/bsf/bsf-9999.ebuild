# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc examples source"

inherit git-r3 java-pkg-2 java-ant-2

EGIT_REPO_URI="https://github.com/apache/commons-bsf"

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="javascript python tcl"

COMMON_DEP="
	dev-java/xalan
	javascript? ( dev-java/rhino:1.6 )
	tcl? ( dev-java/jacl )"
RDEPEND=">=virtual/jre-1.6
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.6
	${COMMON_DEP}"

java_prepare() {
	rm -v lib/*.jar || die

	java-ant_rewrite-classpath
}

src_compile() {
	local pkgs="xalan"
	local antflags="-Dxalan.present=true"

	if use javascript; then
		antflags="${antflags} -Drhino.present=true"
		pkgs="${pkgs},rhino-1.6"
	fi
	if use tcl; then
		antflags="${antflags} -Djacl.present=true"
		pkgs="${pkgs},jacl"
	fi

	local cp="$(java-pkg_getjars ${pkgs})"
	eant -Dgentoo.classpath="${cp}" ${antflags} jar
	# stupid clean
	mv build/lib/${PN}.jar ${S} || die
	use doc && eant -Dgentoo.classpath="${cp}" ${antflags} javadocs
}

src_install() {
	java-pkg_dojar ${PN}.jar

	java-pkg_dolauncher ${PN} --main org.apache.bsf.Main

	dodoc CHANGES.txt NOTICE.txt README.txt RELEASE-NOTE.txt TODO.txt || die

	use doc && java-pkg_dojavadoc build/javadocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/org

	java-pkg_register-optional-dependency bsh,groovy
}
