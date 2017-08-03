# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2

MY_PN="ecj"
DMF="R-${PV}-201602121500"

DESCRIPTION="Eclipse Compiler for Java"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/eclipse/downloads/drops4/${DMF}/${MY_PN}src-${PV}.jar"

LICENSE="EPL-1.0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
SLOT="4.5"
IUSE="+ant userland_GNU"

COMMON_DEP="
	|| ( app-eselect/eselect-java app-eselect/eselect-ecj )"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.7"
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.7
	app-arch/unzip
	userland_GNU? ( sys-apps/findutils )"
PDEPEND="
	ant? ( ~dev-java/ant-eclipse-ecj-${PV}:${SLOT} )"

S="${WORKDIR}"

java_prepare() {
	epatch "${FILESDIR}/remove-dep-core.patch"

	# These have their own package.
	rm -v org/eclipse/jdt/core/JDTCompilerAdapter.java || die
	rm -rv org/eclipse/jdt/internal/antadapter || die

	rm build.xml || die
	rm META-INF/eclipse.inf
}

src_compile() {
	local javac_opts javac java jar

	javac_opts="$(java-pkg_javac-args) -encoding ISO-8859-1"
	javac="$(java-config -c)"
	java="$(java-config -J)"
	jar="$(java-config -j)"

	mkdir -p bootstrap || die
	cp -pPR org META-INF bootstrap || die
	cd "${S}/bootstrap" || die

	einfo "bootstrapping ${MY_PN} with ${javac} ..."

	${javac} ${javac_opts} $(find org/ -name '*.java') || die

	find org/ META-INF/ \( -name '*.class' -o -name '*.properties' -o -name '*.rsc' -o -name '*.inf' -o -name '*.props' \) \
		-exec ${jar} cf ${MY_PN}.jar {} + || die

	cd "${S}" || die
	einfo "building ${MY_PN} with bootstrapped ${MY_PN} ..."

	${java} -classpath bootstrap/${MY_PN}.jar \
		org.eclipse.jdt.internal.compiler.batch.Main \
		${javac_opts} -nowarn org || die

	find org/ META-INF/ \( -name '*.class' -o -name '*.properties' -o -name '*.rsc' -o -name '*.inf' -o -name '*.props' \) \
		-exec ${jar} cf ${MY_PN}.jar {} + || die
}

src_install() {
	java-pkg_dolauncher ${MY_PN}-${SLOT} --main \
		org.eclipse.jdt.internal.compiler.batch.Main

	java-pkg_dojar ${MY_PN}.jar
}

pkg_postinst() {
	einfo "To select between slots of ECJ..."
	einfo " # eselect ecj"

	eselect ecj update ecj-${SLOT}
}

pkg_postrm() {
	eselect ecj update
}
