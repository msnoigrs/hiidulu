# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

ESVN_REPO_URI="https://svn.codehaus.org/qdox/tags/qdox-1.12"
JAVA_PKG_IUSE="doc source junit"

inherit subversion java-pkg-2 java-ant-2

DESCRIPTION="Parser for extracting class/interface/method definitions"
HOMEPAGE="http://qdox.codehaus.org/"
#SRC_URI="http://snapshots.repository.codehaus.org/com/thoughtworks/qdox/qdox/1.12-SNAPSHOT/qdox-1.12-20100531.205010-5-project.tar.gz  "
LICENSE="Apache-2.0"
SLOT="1.12"
KEYWORDS="~x86 ~amd64"
IUSE=""
#S="${WORKDIR}/${PN}-${PV}-SNAPSHOT"

COMMON_DEP="junit? ( dev-java/junit:4 )"
RDEPEND=">=virtual/jre-1.5
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.5
	${COMMON_DEP}
	dev-java/ant-core
	>=dev-java/byaccj-1.14
	>=dev-java/jflex-1.4.2
	sys-apps/sed"

java_prepare() {
	find . -depth -name .svn -type d -delete

	mkdir lib || die
	cd lib
	java-pkg_jarfrom --build-only ant-core ant.jar

	if use junit; then
		java-pkg_jarfrom junit-4 junit.jar
	else
		rm -rf ${S}/src/java/com/thoughtworks/qdox/junit
	fi
}

src_compile() {
	local impldir="src/java/com/thoughtworks/qdox/parser/impl"
	mkdir -p ${impldir}
	jflex -d ${impldir} --skel src/grammar/skeleton.inner src/grammar/lexer.flex || die "jflex failed"
	byaccj -v -Jnorun -Jnoconstruct -Jclass=Parser -Jsemantic=Value -Jpackage=com.thoughtworks.qdox.parser.impl src/grammar/parser.y
	mv Parser.java ${impldir} || die

	local classes="${S}/target/classes"
	local javadocdir="${S}/dist/docs/api"
	local cps="${S}/lib/ant.jar"
	cps="${cps}:${S}/lib/junit.jar"
	cps="${cps}:."

	cd ${S}
	mkdir -p ${classes}
	cd ${S}/src/java

	ejavac -d ${classes} -cp ${cps} $(find -name "*.java")

	jar cf ${S}/target/${PN}.jar -C ${classes} . || die "cannot create jar"

	if use doc; then
		mkdir -p ${javadocdir}
		srcdirs="com.thoughtworks.qdox
				com.thoughtworks.qdox.ant
				com.thoughtworks.qdox.directorywalker
				com.thoughtworks.qdox.model
				com.thoughtworks.qdox.model.annotation
				com.thoughtworks.qdox.model.util
				com.thoughtworks.qdox.parser
				com.thoughtworks.qdox.parser.impl
				com.thoughtworks.qdox.parser.structs
				com.thoughtworks.qdox.tools"
		if use junit; then
			srcdirs="${srcdirs} com.thoughtworks.qdox.junit"
		fi

		javadoc -classpath ${cps} -d ${javadocdir} ${srcdirs}
	fi
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	java-pkg_register-ant-task

	use source && java-pkg_dosrc src/java/com
	use doc && java-pkg_dojavadoc javadoc
}
