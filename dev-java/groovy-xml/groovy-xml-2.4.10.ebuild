# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple versionator

# Switch to ^^ when we switch to EAPI=6.
#MY_PN="${PN^^}"
MY_PN="GROOVY"
MY_PV="$(replace_all_version_separators _ ${PV})"
MY_P="${MY_PN}_${MY_PV}"

MY_OP="groovy-${PV}"

DESCRIPTION="A multi-faceted language for the Java platform"
HOMEPAGE="http://www.groovy-lang.org/"
SRC_URI="https://github.com/apache/incubator-groovy/archive/${MY_P}.zip -> ${MY_OP}.zip"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

CDEPEND="
	dev-java/groovy:0
"

RDEPEND="
	${CDEPEND}
	>=virtual/jre-1.6"
DEPEND="
	${CDEPEND}
	>=virtual/jdk-1.6"

JAVA_GENTOO_CLASSPATH="
	groovy
"

S="${WORKDIR}/groovy-${MY_P}/subprojects/${PN}"

groovy_compile() {
	local sources=gsources.lst classes=target/classes

	# gather sources
	find src/main/groovy -name \*.groovy > ${sources}

	# compile
	local classpath="${JAVA_GENTOO_CLASSPATH_EXTRA}" dependency
	for dependency in ${JAVA_GENTOO_CLASSPATH}; do
		classpath="${classpath}:$(java-pkg_getjars ${dependency})" \
			|| die "getjars failed for ${dependency}"
	done
	while [[ $classpath = *::* ]]; do classpath="${classpath//::/:}"; done
	classpath=${classpath%:}
	classpath=${classpath#:}

	groovyc -d ${classes} -encoding ${JAVA_ENCODING} \
			${classpath:+-classpath ${classpath}} ${JAVAC_ARGS} \
			@${sources} || die

	# package
	local jar_args="cf ${JAVA_JAR_FILENAME}"
	if [[ -e ${classes}/META-INF/MANIFEST.MF ]]; then
		jar_args="cfm ${JAVA_JAR_FILENAME} ${classes}/META-INF/MANIFEST.MF"
	fi
	jar ${jar_args} -C ${classes} . || die "jar failed"
}

# Add target/classes to the CP as we're generating an extra class there.
JAVA_GENTOO_CLASSPATH_EXTRA="target/classes"

JAVA_SRC_DIR="src/main/java"

src_compile() {
	services="target/classes/META-INF/services"
	mkdir -p ${services} || die
	cp "${FILESDIR}/org.codehaus.groovy.runtime.ExtensionModule" ${services} || die
	java-pkg-simple_src_compile
	groovy_compile
}

src_install() {
	java-pkg-simple_src_install
}
