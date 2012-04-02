# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Groovy's build system is Ant based, but they use Maven for fetching the dependencies.
# We just have to remove the fetch dependencies target, and then we can use Ant for this ebuild.

# We currently do not build the embeddable jar (which is created using JarJar).
# We could provide that via an USE flag.
# We also don't use automatic build rewriting as there seems to be already some level of support
# in the upstream build system

# TODO: Install all 3 documentation packages. Currently only the Groovy GDK documentation is installed
# as our java-pkg_dojavadoc function does not support multiple Javadoc installations.

EAPI="3"
WANT_ANT_TASKS="ant-antlr"
JAVA_PKG_IUSE="doc source"

inherit versionator java-pkg-2 java-ant-2

MY_PV=${PV/_rc/-RC-}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Groovy is a high-level dynamic language for the JVM"
HOMEPAGE="http://groovy.codehaus.org/"

SRC_URI="http://dist.groovy.codehaus.org/distributions/${PN}-src-${PV}.zip"
LICENSE="codehaus-groovy"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"
RESTRICT="test"

CDEPEND=">=dev-java/asm-3.2
	>=dev-java/ant-core-1.8.0
	dev-java/xstream
	dev-java/jline
	dev-java/commons-cli
	dev-java/jansi
	dev-java/junit:4
	dev-java/ant-ivy:2
	dev-java/ant-antlr
	dev-java/ant-junit
	>=dev-java/bsf-2.4
	dev-java/antlr:0
	dev-java/jsr166y
	dev-java/extra166y
	java-virtuals/servlet-api:3.0
	dev-java/hamcrest-core:0
	dev-java/xpp3
	java-virtuals/jmx"

RDEPEND=">=virtual/jre-1.5
	!<dev-java/groovy-1.6.3
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	doc? (
		dev-java/qdox
	)
	test? (
		dev-java/jmock
		dev-java/xmlunit
		dev-db/hsqldb
		dev-java/commons-logging
		dev-java/ant-trax
	)
	${CDEPEND}"

S="${WORKDIR}/${MY_P}"

JAVA_PKG_BSFIX=""

src_prepare() {
	#sed -i -e '/setDefaultPrompt/ a reader.setDebug(new PrintWriter(new java.io.BufferedWriter(new java.io.FileWriter(new java.io.File("/tmp/jline.log")))));' src/main/groovy/ui/InteractiveShell.java || die
#	cp ${FILESDIR}/InteractiveShell.java src/main/groovy/ui

	rm -rf bootstrap
	# security directory is needed for tests, but they currently don't pass
	#rm -rf security
	mkdir -p target/lib && cd target/lib
	mkdir compile && mkdir runtime && mkdir tools
	cd compile

#	java-pkg_jar-from commons-cli-1,ant-core,antlr,asm-3,xstream,jansi
	java-pkg_jar-from commons-cli-1,ant-core,antlr,asm-3,xstream
	java-pkg_jar-from ant-junit,ant-antlr
#	java-pkg_jar-from jline,junit,servletapi-3.0,bsf-2.3
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from jansi
	java-pkg_jar-from jline
	java-pkg_jar-from junit-4
	java-pkg_jar-from --virtual servlet-api-3.0
	java-pkg_jar-from --virtual jmx
	java-pkg_jar-from ant-ivy-2
	use doc && java-pkg_jar-from --build-only qdox-1.6
}

src_compile() {
	eant -DskipTests="true" -DruntimeLibDirectory="target/lib/compile" \
		-DtoolsLibDirectory="target/lib/compile" -DskipFetch="true" -DskipEmbeddable="true"

	use doc && ANT_TASKS="ant-antlr" ANT_OPTS="-Duser.home=${T}" eant -Dno.grammars="true" -DruntimeLibDirectory="target/lib/compile" \
	 -DtoolsLibDirectory="target/lib/compile" -DtestLibDirectory="target/lib/compile" -DskipFetch="true" doc
}

src_test() {
	cd "${S}/target/lib" && mkdir test && mkdir extras && cd compile

	java-pkg_jar-from --build-only ant-junit,jmock-1.0,xmlunit-1,hsqldb,commons-logging,cglib-2.1

	cd "${S}"
	ANT_TASKS="ant-junit ant-antlr ant-trax" ANT_OPTS="-Duser.home=${T}" eant \
		-DruntimeLibDirectory="target/lib/compile" -DtestLibDirectory="target/lib/compile" -DskipFetch="true" test
}

groovy_app_dosh() {
	sed -e "s:@@GROOVY_APP_MAIN@@:${2}:" \
		-e "s:@@GROOVY_HOME@@:${GROOVY_HOME}:" \
		"${FILESDIR}"/cmdTemplate.sh > "${D}"/usr/bin/"${1}"
	fperms 755 /usr/bin/"${1}"
}

src_install() {
	java-pkg_dojar "target/dist/${PN}.jar"
	#java-pkg_dojar "target/dist/gpars.jar"

	GROOVY_NAME="groovy"
	local GROOVY_HOME="/usr/$(get_libdir)/${GROOVY_NAME}"

	dodir ${GROOVY_HOME}

	dodir ${GROOVY_HOME}/bin
	sed -e "s:@@GROOVY_HOME@@:${GROOVY_HOME}:" "${FILESDIR}"/startGroovy > "${D}"/${GROOVY_HOME}/bin/startGroovy

	dodir /usr/bin
	groovy_app_dosh grape org.codehaus.groovy.tools.GrapeMain
	groovy_app_dosh groovy groovy.ui.GroovyMain
	groovy_app_dosh groovyConsole groovy.ui.Console
	groovy_app_dosh groovyc org.codehaus.groovy.tools.FileSystemCompiler
	groovy_app_dosh groovydoc org.codehaus.groovy.tools.groovydoc.Main
	groovy_app_dosh groovysh org.codehaus.groovy.tools.shell.Main
	groovy_app_dosh java2groovy org.codehaus.groovy.antlr.java.Java2GroovyMain

	dodir ${GROOVY_HOME}/lib
	dosym /usr/share/groovy/lib/${PN}.jar ${GROOVY_HOME}/lib/${PN}.jar
	#dosym /usr/share/groovy/lib/gpars.jar ${GROOVY_HOME}/lib/gpars.jar
	cd "${D}"/${GROOVY_HOME}/lib
	java-pkg_jar-from ant-core ant.jar
	java-pkg_jar-from ant-core ant-launcher.jar
	java-pkg_jar-from ant-antlr
	java-pkg_jar-from ant-junit
	java-pkg_jar-from antlr
	java-pkg_jar-from asm-3
	java-pkg_jar-from bsf-2.3
	java-pkg_jar-from commons-cli-1
	java-pkg_jar-from extra166y
	java-pkg_jar-from hamcrest-core
	java-pkg_jar-from ant-ivy-2
	java-pkg_jar-from jansi
	java-pkg_jar-from jline
	java-pkg_jar-from --virtual servlet-api-3.0
	java-pkg_jar-from jsr166y
	java-pkg_jar-from junit-4
	java-pkg_jar-from xpp3
	java-pkg_jar-from xstream

	cd "${S}"
	dodir /etc/${GROOVY_NAME}
	insinto /etc/${GROOVY_NAME}
	doins src/conf/groovy-starter.conf
	dosym /etc/${GROOVY_NAME} ${GROOVY_HOME}/conf

	use doc && java-pkg_dojavadoc "target/html/groovy-jdk/"

	java-pkg_register-ant-task
	# FIXME: install those two later
	#
	#use doc && java-pkg_dojavadoc "target/html/api/"
	#use doc && java-pkg_dojavadoc "target/html/gapi/"

	use source && java-pkg_dosrc "src/main/groovy" "src/main/org"
	#java-pkg_dolauncher "groovyc" --main org.codehaus.groovy.tools.FileSystemCompiler
	#java-pkg_dolauncher "groovy" --main groovy.ui.GroovyMain
	#java-pkg_dolauncher "groovysh" --main groovy.ui.InteractiveShell
	#java-pkg_dolauncher "groovyConsole" --main groovy.ui.Console
	#java-pkg_dolauncher "grape" --main org.codehaus.groovy.tools.GrapeMain
}
