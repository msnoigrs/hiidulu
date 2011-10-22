# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
JAVA_PKG_IUSE="doc examples source"
inherit subversion java-pkg-2 java-ant-2

#ESVN_OPTIONS="-r${PV/*_p}" # BSFMager version 242.20070128"
#ESVN_REPO_URI="http://svn.apache.org/repos/asf/jakarta/bsf/trunk"
ESVN_REPO_URI="http://svn.apache.org/repos/asf/commons/proper/bsf/trunk"

DESCRIPTION="Bean Script Framework"
HOMEPAGE="http://jakarta.apache.org/bsf/"
#SRC_URI="mirror://apache/jakarta/bsf/source/${PN}-src-${PV}.tar.gz"
SRC_URI=""
LICENSE="Apache-2.0"
SLOT="2.3"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
#IUSE="python javascript tcl"
IUSE="javascript tcl"


#COMMON_DEP="dev-java/jcl-over-slf4j
#	python? ( dev-java/jython:2.5 )
COMMON_DEP="
	dev-java/xalan
	javascript? ( dev-java/rhino:1.6 )
	tcl? ( dev-java/jacl )"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}"

java_prepare() {
	rm -v lib/*.jar || die
	#rm samples/*/*.class || die

#	java-ant_ignore-system-classes
	java-ant_rewrite-classpath

	# somebody forgot to add them to source tarball... fetched from svn
	#cp "${FILESDIR}/${P}-build-properties.xml" build-properties.xml || die
}

src_compile() {
	local pkgs="xalan"
	local antflags="-Dxalan.present=true"
#	if use python; then
#		antflags="${antflags} -Djython.present=true"
#		pkgs="${pkgs},jython-2.5"
#	fi
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

#	java-pkg_register-optional-dependency bsh,groovy,jruby
	java-pkg_register-optional-dependency bsh,groovy
}

#pkg_postinst() {
#	elog "Support for python, javascript, and tcl is controlled via USE flags."
#	elog "Also, following languages can be supported just by installing"
#	elog "respective package with USE=\"bsf\": BeanShell (dev-java/bsh),"
#	elog "Groovy (dev-java/groovy) and JRuby (dev-java/jruby)"
#}
