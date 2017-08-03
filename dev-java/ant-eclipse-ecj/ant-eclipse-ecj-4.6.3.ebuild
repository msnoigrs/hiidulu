# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit java-pkg-2 prefix

DMF="R-${PV}-201703010400"
S="${WORKDIR}"

DESCRIPTION="Ant Compiler Adapter for Eclipse Java Compiler"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://www.eclipse.org/downloads/download.php?file=%2Feclipse%2Fdownloads%2Fdrops4%2F${DMF}%2Fecjsrc-${PV}.jar&r=1 -> ecjsrc-${PV}.jar"

LICENSE="EPL-1.0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
SLOT="4.6"
IUSE=""

RDEPEND=">=virtual/jre-1.7
	~dev-java/eclipse-ecj-${PV}:${SLOT}
	>=dev-java/ant-core-1.7:0"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=virtual/jdk-1.7"

src_unpack() {
	unpack ${A}
	mkdir -p src/org/eclipse/jdt/{core,internal}
	cp org/eclipse/jdt/core/JDTCompilerAdapter.java \
		src/org/eclipse/jdt/core || die
	cp -r org/eclipse/jdt/internal/antadapter \
		src/org/eclipse/jdt/internal || die
	rm -fr about* org
	rm build.xml || die
}

src_compile() {
	cd src
	ejavac -classpath "$(java-pkg_getjars ant-core,eclipse-ecj-${SLOT})" \
		$(find org/ -name '*.java') || die "ejavac failed!"
	find org/ -name '*.class' -o -name '*.properties' | \
			xargs jar cf "${S}/${PN}.jar" || die "jar failed!"
}

src_install() {
	java-pkg_dojar ${PN}.jar
	insinto /usr/share/java-config-2/compiler
	doins "${FILESDIR}/ecj-${SLOT}"
	eprefixify "${D}"/usr/share/java-config-2/compiler/ecj-${SLOT}
}
