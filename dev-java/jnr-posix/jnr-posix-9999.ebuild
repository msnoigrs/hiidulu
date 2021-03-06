# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source doc"
WANT_ANT_TASKS="ant-nodeps"

EGIT_REPO_URI="git://github.com/jnr/jnr-posix.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="Lightweight cross-platform POSIX emulation layer for Java"
HOMEPAGE="http://github.com/jnr/jnr-posix/"
#SRC_URI="http://github.com/wmeissner/${PN}/tarball/${PV} -> ${P}.tar.gz"
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

#CDEPEND=">=dev-java/jaffl-0.5.1:0
CDEPEND="dev-java/jnr-ffi:0
	dev-java/jnr-constants"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	test? (
		dev-java/ant-junit4
		dev-java/jffi:0.4
	)"

java_prepare() {
	cp ${FILESDIR}/gentoo-build.xml build.xml

#	find . -iname '*.jar' -delete
	mkdir lib || die
	java-pkg_jar-from --into lib jnr-constants
	java-pkg_jar-from --into lib jnr-ffi
	ln -s $(java-config --tools) lib/tools.jar

#	sed -i -e 's_\.\./jaffl\.git/__g' nbproject/project.properties || die

#	sed -i -e 's/\(DefaultNativeTimeval\)/com.kenai.jaffl.Runtime.getDefault(), \1/' src/org/jruby/ext/posix/BaseNativePOSIX.java
#	sed -i -e 's/Timeval\[\]/DefaultNativeTimeval[]/' src/org/jruby/ext/posix/BaseNativePOSIX.java
#	sed -i -e 's/com.kenai.jaffl.Pointer.SIZE/com.kenai.jaffl.Platform.getPlatform().addressSize()/' src/org/jruby/ext/posix/DefaultNativeGroup.java
}

#EANT_EXTRA_ARGS="-Dreference.jaffl.jar=lib/jaffl.jar \
#	-Dreference.constantine.jar=lib/constantine.jar \
#	-Dproject.constantine=\"${S}\" \
#	-Dproject.jaffl=\"${S}\" \
#	-D\"already.built.${S}\"=true"

EANT_EXTRA_ARGS="-Dproject.name=${PN}"

src_install() {
#	java-pkg_dojar dist/${PN}.jar
#	use source && java-pkg_dosrc src/*

	java-pkg_dojar target/${PN}.jar

	use doc && java-pkg_dojavadoc target/site/apidocs
	use source && java-pkg_dosrc src/main/java/*

	dodoc README.txt || die
}

#src_test() {
#	sed -i -e \
#	"s_\${file.reference.jffi-complete.jar}_$(java-pkg_getjars --build-only --with-dependencies jffi-0.4,jaffl)_" \
#		nbproject/project.properties

#	ANT_TASKS="ant-junit4 ant-nodeps" eant test \
#		-Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)" \
#		-Djava.library.path="$(java-config -di jaffl,constantine,jffi-0.4)" \
#		${EANT_EXTRA_ARGS}
#}
