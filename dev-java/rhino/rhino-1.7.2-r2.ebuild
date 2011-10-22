# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

JAVA_PKG_IUSE="doc examples source"
inherit java-pkg-2 java-ant-2 eutils versionator

MY_P="${PN}$(replace_version_separator 1 _ $(replace_version_separator 2 R))"

DESCRIPTION="An open-source implementation of JavaScript written in Java."
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.zip
	mirror://gentoo/rhino-swing-ex-1.0.zip"
#http://mxr.mozilla.org/mozilla/source/js/rhino/
HOMEPAGE="http://www.mozilla.org/rhino/"
# dual license for rhino and BSD-2 for the swing-ex from Sun's tutorial
LICENSE="|| ( MPL-1.1 GPL-2 ) BSD-2"
SLOT="1.6"
KEYWORDS="amd64 ~ia64 ppc ppc64 x86 ~x86-fbsd"
IUSE="xmlbeans"

S="${WORKDIR}/${MY_P}"

CDEPEND="xmlbeans? ( >=dev-java/xml-xmlbeans-2.2 )"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip
	${CDEPEND}"

src_unpack() {
	unpack ${MY_P}.zip
}

java_prepare() {
	# don't download src.zip from Sun
	epatch "${FILESDIR}/rhino-1.6-noget.patch"
	epatch "${FILESDIR}/xmlbeans-noget.patch"

	rm -v *.jar || die
	rm -rf docs/apidocs || die

	local dir="toolsrc/org/mozilla/javascript/tools/debugger/downloaded"
	mkdir ${dir} || die
	cp "${DISTDIR}/rhino-swing-ex-1.0.zip" ${dir}/swingExSrc.zip || die

	cd "${S}"
	if use xmlbeans; then
		echo "xbean.jar=$(java-pkg_getjar xml-xmlbeans-2 xbean.jar)" >> build.properties
	else
		echo "no-xmlbeans=true" >> build.properties
	fi
}

src_install() {
	java-pkg_dojar build/${MY_P}/js.jar

	java-pkg_dolauncher jsscript-${SLOT} \
		--main org.mozilla.javascript.tools.shell.Main
	java-pkg_dolauncher jsscript-debugger-${SLOT} \
		--main org.mozilla.javascript.tools.debugger.Main

	if use doc; then
		local dir="build/${MY_P}/docs"
		mv "${dir}"/{apidocs,api} || die
		java-pkg_dohtml -r "${dir}"/*
		dosym /usr/share/doc/${PF}/html/{api,apidocs} || die
	fi
	use doc && java-pkg_dojavadoc "build/${MY_P}/javadoc"
	use examples && java-pkg_doexamples examples
	use source && java-pkg_dosrc {src,toolsrc,xmlimplsrc}/org
}
