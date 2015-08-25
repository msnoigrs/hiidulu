# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit java-pkg-2

MY_PN=${PN%%-bin}
MY_P="${MY_PN}-${PV/_rc/-rc-}"

DESCRIPTION="A project automation and build tool similar to Apache Ant and Apache Maven with a Groovy based DSL"
SRC_URI="http://services.gradle.org/distributions/${MY_P}-all.zip"
HOMEPAGE="http://www.gradle.org/"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="~x86 ~amd64"

DEPEND="app-arch/zip
	app-eselect/eselect-gradle"
RDEPEND=">=virtual/jdk-1.6
	dev-java/ant-core:0
	dev-java/asm:5
	dev-java/commons-collections:0
	dev-java/commons-io:1
	dev-java/commons-lang:2.1
	dev-java/dom4j:1
	dev-java/guava:17
	dev-java/jarjar:1
	dev-java/javax-inject:0
	dev-java/jaxen:1.1
	dev-java/jcip-annotations:0
	dev-java/jcl-over-slf4j:0
	dev-java/jul-to-slf4j:0
	dev-java/log4j-over-slf4j:0
	dev-java/slf4j-api:0
	dev-java/minlog:0
	dev-java/reflectasm:0
	dev-java/objenesis:0"
	#dev-java/kryo:2"
	#=dev-java/jansi-9999:0
	#=dev-java/jansi-native-9999:0
	#dev-java/hawtjni-runtime:0

IUSE="source doc examples"

S="${WORKDIR}/${MY_P}"

INSTALL_DIR=/usr/share/"${PN}-${SLOT}"

src_install() {
	local gradle_dir="${EROOT%/}${INSTALL_DIR}"

	dodoc changelog.txt getting-started.html

	# source
	if use source; then
		insinto "${INSTALL_DIR}"/src
		doins -r src/*
	fi

	# docs
	if use doc ; then
		insinto "${INSTALL_DIR}"/docs
		doins -r docs/*
	fi

	# examples
	if use examples ; then
		insinto "${INSTALL_DIR}"/samples
		doins -r samples/*
	fi

	# jars in lib/
	# Note that we can't strip the version from the gradle jars,
	# because then gradle won't find them.
	insinto "${INSTALL_DIR}"/lib
	doins -r lib/*

	insinto "${INSTALL_DIR}"/media
	doins media/*

	insinto "${INSTALL_DIR}"/init.d
	doins init.d/*

	java-pkg_newjar lib/gradle-launcher-2.6.jar gradle-launcher.jar
	java-pkg_register-dependency jansi

	java-pkg_dolauncher "${PN}-${SLOT}" --main org.gradle.launcher.GradleMain --java_args "-Dgradle.home=${gradle_dir} \${GRADLE_OPTS}"

	local instdir="${INSTALL_DIR}"/lib
	pushd "${ED}"/${instdir} >/dev/null || die
	rm gradle-launcher-2.6.jar && dosym ${gradle_dir}/lib/gradle-launcher.jar ${instdir}/gradle-launcher-2.6.jar || die

	rm ant-launcher-1.9.3.jar && dosym /usr/share/ant/lib/ant-launcher.jar ${instdir}/ant-launcher-1.9.3.jar || die
	rm ant-1.9.3.jar && dosym /usr/share/ant/lib/ant.jar ${instdir}/ant-1.9.3.jar || die
	rm asm-all-5.0.3.jar && dosym /usr/share/asm-5/lib/asm-all.jar ${instdir}/asm-all-5.0.3.jar || die
	rm commons-collections-3.2.1.jar && dosym /usr/share/commons-collections/lib/commons-collections.jar ${instdir}/commons-collections-3.2.1.jar || die
	rm commons-io-1.4.jar && dosym /usr/share/commons-io-1/lib/commons-io.jar ${instdir}/commons-io-1.4.jar || die
	rm commons-lang-2.6.jar && dosym /usr/share/commons-lang-2.1/lib/commons-lang.jar ${instdir}/commons-lang-2.6.jar || die
	rm dom4j-1.6.1.jar && dosym /usr/share/dom4j-1/lib/dom4j.jar ${instdir}/dom4j-1.6.1.jar || die
	rm guava-jdk5-17.0.jar && dosym /usr/share/guava-17/lib/guava.jar ${instdir}/guava-jdk5-17.0.jar || die
	#rm jansi-1.2.1.jar && dosym /usr/share/jansi/lib/jansi.jar ${instdir}/jansi-1.2.1.jar || die
	#rm jna-3.2.7.jar && dosym /usr/share/jansi-native/lib/jansi-native.jar ${instdir}/jna-3.2.7.jar || die
	rm jarjar-1.3.jar && dosym /usr/share/jarjar-1/lib/jarjar-nodep.jar ${instdir}/jarjar-1.3.jar || die
	rm javax.inject-1.jar && dosym /usr/share/javax-inject/lib/javax.inject.jar ${instdir}/javax.inject-1.jar || die
	rm jaxen-1.1.jar && dosym /usr/share/jaxen-1.1/lib/jaxen.jar ${instdir}/jaxen-1.1.jar || die
	rm jcip-annotations-1.0.jar && dosym /usr/share/jcip-annotations/lib/jcip-annotations.jar ${instdir}/jcip-annotations-1.0.jar || die
	rm jcl-over-slf4j-1.7.10.jar && dosym /usr/share/jcl-over-slf4j/lib/jcl-over-slf4j.jar ${instdir}/jcl-over-slf4j-1.7.10.jar || die
	rm jul-to-slf4j-1.7.10.jar && dosym /usr/share/jul-to-slf4j/lib/jul-to-slf4j.jar ${instdir}/jul-to-slf4j-1.7.10.jar || die
	rm log4j-over-slf4j-1.7.10.jar && dosym /usr/share/log4j-over-slf4j/lib/log4j-over-slf4j.jar ${instdir}/log4j-over-slf4j-1.7.10.jar || die
	rm slf4j-api-1.7.10.jar && dosym /usr/share/slf4j-api/lib/slf4j-api.jar ${instdir}/slf4j-api-1.7.10.jar || die
	rm minlog-1.2.jar && dosym /usr/share/minlog/lib/minlog.jar ${instdir}/minlog-1.2.jar || die
	rm reflectasm-1.07-shaded.jar && dosym /usr/share/reflectasm/lib/reflectasm-shaded.jar ${instdir}/reflectasm-1.07-shaded.jar || die
	rm objenesis-1.2.jar && dosym /usr/share/objenesis/lib/objenesis.jar ${instdir}/objenesis-1.2.jar || die
	#rm kryo-2.20.jar && dosym /usr/share/kryo-2/lib/kryo.jar ${instdir}/kryo-2.20.jar || die

	popd >/dev/null || die
}

pkg_postinst() {
	eselect gradle update ifunset
}

pkg_postrm() {
	eselect gradle update ifunset
}
