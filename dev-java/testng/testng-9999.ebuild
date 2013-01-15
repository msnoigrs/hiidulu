# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="doc source test"

WANT_ANT_TASKS="dev-java/ant-ivy:2"

EGIT_REPO_URI="git://github.com/cbeust/testng.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="TestNG is a testing framework inspired from JUnit and NUnit"
HOMEPAGE="http://testng.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-java/bsh:0
		dev-java/snakeyaml
		dev-java/jcommander:0
		dev-java/guice:3
		dev-java/junit:4"
#		dev-java/qdox:1.6"

DEPEND=">=virtual/jdk-1.5
		dev-java/ant-core:0
		${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
		${CDEPEND}"

#QDOX_NAME="qdox-1.6.1.jar"
#BSH_NAME="bsh-2.0b4.jar"

java_prepare() {
	find . -iname '*.jar' -exec rm -v {} +

	sed -i -e 's/com.google.inject.internal.Lists/com.google.inject.internal.util.Lists/g' \
		-e 's/Lists/$Lists/g' src/main/java/org/testng/xml/XmlGroups.java
	sed -i -e 's/com.google.inject.internal.Maps/com.google.inject.internal.util.Maps/g' \
		-e 's/Maps/$Maps/g' src/main/java/org/testng/xml/XmlDependencies.java
	sed -i -e 's/com.google.inject.internal.Maps/com.google.inject.internal.util.Maps/g' \
		-e 's/Maps/$Maps/g' src/main/java/org/testng/xml/dom/TestNGTagFactory.java

	sed -i -e 's/depends="retrieve-dependencies"//' build.xml
	mkdir lib

	java-pkg_jar-from --into lib --build-only ant-core ant.jar
	java-pkg_jar-from --into lib junit-4
	java-pkg_jar-from --into lib snakeyaml snakeyaml.jar snakeyaml-1.6.jar
	java-pkg_jar-from --into lib jcommander jcommander.jar jcommander-1.27.jar
	java-pkg_jar-from --into lib bsh bsh.jar bsh-2.0b4.jar
	java-pkg_jar-from --into lib guice-3 guice.jar

	# Creaty empty jars to fool the unpacking
#	cd "${S}/3rdparty" || die
#	touch empty
#	jar cf ${QDOX_NAME} empty
#	jar cf ${BSH_NAME} empty

#	sed -i -e 's/tag.getContext().getSource()/tag.getContext().getParent().getParentSource()/g' src/main/org/testng/internal/AnnotationTestConverter.java
#	sed -i -e 's/writeFile(file, source.getPackage(), finalLines)/writeFile(file, source.getPackage().toString(), finalLines)/' src/main/org/testng/internal/AnnotationTestConverter.java

#	sed -i -e '/fileset dir="\${lib.dir}"/a <include name="tools.jar"/>' build.xml
#	sed -i -e '/fileset dir="\${lib.dir}"/a <include name="ant.jar"/>' build.xml

#	java-pkg_jar-from --into 3rdparty bsh bsh.jar bsh-2.0b4.jar
#	java-pkg_jar-from --into 3rdparty qdox-1.6 qdox.jar qdox-1.6.1.jar
#	java-pkg_jar-from --into 3rdparty junit
#	java-pkg_jar-from --into 3rdparty --build-only ant-core ant.jar
#	ln -s $(java-config -t) 3rdparty/tools.jar
}

#JAVA_ANT_REWRITE_CLASSPATH="true"
#JAVA_ANT_CLASSPATH_TAGS="javac testng"

#EANT_GENTOO_CLASSPATH="bsh,qdox-1.6,ant-core,junit"
#EANT_BUILD_TARGET="dist-bsh-noguice"
#EANT_DOC_TARGET="javadocs"

src_compile() {
	EANT_BUILD_TARGET="build" EANT_EXTRA_ARGS="-Dall.jar.files=*.jar -Djunit.jar=junit.jar" java-pkg-2_src_compile
}

src_install() {
#	java-pkg_newjar "${P}-jdk15.jar" "${PN}.jar"
	java-pkg_newjar target/testng*.jar
	java-pkg_register-ant-task

	use doc && java-pkg_dojavadoc javadocs/
#	use source && java-pkg_dosrc src/jdk15/org/testng/
	use source && java-pkg_dosrc src/main/java/*
}

#src_test() {
#	eant -f test/build.xml run
#}
