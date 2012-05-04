# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
JAVA_PKG_IUSE="source test"
WANT_ANT_TASKS="ant-nodeps"

EGIT_REPO_URI="git://github.com/wmeissner/jnr-posix.git"

inherit java-pkg-2 java-ant-2 git-2

DESCRIPTION="Lightweight cross-platform POSIX emulation layer for Java"
HOMEPAGE="http://github.com/wmeissner/jnr-posix/"
#SRC_URI="http://github.com/wmeissner/${PN}/tarball/${PV} -> ${P}.tar.gz"
SRC_URI=""
LICENSE="|| ( CPL-1.0 GPL-2 LGPL-2.1 )"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

#	dev-java/wmeissner-jffi
#	dev-java/wmeissner-jnr-constants
#	dev-java/jffi:0.4
#>=dev-java/jaffl-0.5.1:0
CDEPEND="
	dev-java/jnr-ffi
	dev-java/jnr-constants"

RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"

DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	test? (
		dev-java/ant-junit4
	)"

#src_unpack() {
#	unpack ${A}
#	mv w* "${P}" || die
#}

java_prepare() {
	find . -iname '*.jar' -delete
	#java-pkg_jar-from --into lib wmeissner-jnr-constants
	#java-pkg_jar-from --into lib wmeissner-jffi jffi-complete.jar
	java-pkg_jar-from --into lib jnr-constants
#	java-pkg_jar-from --into lib jffi-0.4 jffi.jar
	java-pkg_jar-from --into lib jnr-ffi
#	java-pkg_jar-from --into lib jaffl

	sed -i -e '/javac.classpath=/ a ${reference.jnr-ffi.jar}: \\' nbproject/project.properties || die

	sed -i -e 's_\.\./jaffl\.git/__g' nbproject/project.properties || die

#	sed -i -e 's/\(DefaultNativeTimeval\)/com.kenai.jaffl.Runtime.getDefault(), \1/' src/org/jruby/ext/posix/BaseNativePOSIX.java
#	sed -i -e 's/Timeval\[\]/DefaultNativeTimeval[]/' src/org/jruby/ext/posix/BaseNativePOSIX.java
#	sed -i -e 's/com.kenai.jaffl.Pointer.SIZE/com.kenai.jaffl.Platform.getPlatform().addressSize()/' src/org/jruby/ext/posix/DefaultNativeGroup.java
}

#	-Dfile.reference.jffi-complete.jar=lib/jffi-complete.jar \
#	-Dreference.constantine.jar=lib/constantine.jar \
EANT_EXTRA_ARGS="-Dreference.jaffl.jar=lib/jaffl.jar \
	-Dreference.constantine.jar=lib/jnr-constants.jar \
	-Dreference.jnr-ffi.jar=lib/jnr-ffi.jar \
	-Dfile.reference.jffi-complete.jar=lib/jffi.jar \
	-Dproject.constantine=\"${S}\" \
	-Dproject.jaffl=\"${S}\" \
	-D\"already.built.${S}\"=true"

src_install() {
	java-pkg_dojar dist/jnr-posix.jar
	use source && java-pkg_dosrc src/*
	dodoc README.txt || die
}

src_test() {
	sed -i -e \
	"s_\${file.reference.jffi-complete.jar}_$(java-pkg_getjars --build-only --with-dependencies wmeissner-jffi,jaffl)_" \
		nbproject/project.properties

	ANT_TASKS="ant-junit4 ant-nodeps" eant test \
		-Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)" \
		-Djava.library.path="$(java-config -di jaffl,constantine,wmeissner-jffi)" \
		${EANT_EXTRA_ARGS}
}
